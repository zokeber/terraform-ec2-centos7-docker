data "aws_availability_zone" "az" {
  count = "${length(var.azs)}"
  name  = "${var.azs[count.index]}"
}

locals {
  az_suffix_num = {
    a = 0
    b = 1
    c = 2
  }
}

resource "aws_subnet" "public" {
  count                   = "${length(var.azs)}"
  vpc_id                  = "${var.vpc_id}"
  cidr_block              = "${cidrsubnet(var.public_sn_cidr, 2, local.az_suffix_num[data.aws_availability_zone.az.*.name_suffix[count.index]])}"
  availability_zone       = "${var.azs[count.index]}"
  map_public_ip_on_launch = true
  tags                    = "${merge(map("Name", "${var.name}-${var.env}-sn-public-${data.aws_availability_zone.az.*.name_suffix[count.index]}"), var.tags)}"
}

resource "aws_eip" "nat_eip" {
  count = "${var.enable_nat_gateway ? length(var.azs) : 0}"
  vpc   = true
}

/*
Why we need redundant nat gateways in each AZ?

If you have resources in multiple Availability Zones and they share one NAT gateway, 
in the event that the NAT gateway’s Availability Zone is down, resources in the other 
Availability Zones lose internet access. To create an Availability Zone-independent 
architecture, create a NAT gateway in each Availability Zone and configure your routing 
to ensure that resources use the NAT gateway in the same Availability Zone.
*/
resource "aws_nat_gateway" "nat_gw" {
  count         = "${var.enable_nat_gateway ? length(var.azs) : 0}"
  allocation_id = "${aws_eip.nat_eip.*.id[count.index]}"
  subnet_id     = "${aws_subnet.public.*.id[count.index]}"
  tags          = "${merge(map("Name", "${var.name}-${var.env}-nat-${data.aws_availability_zone.az.*.name_suffix[count.index]}"), var.tags)}"

  lifecycle {
    create_before_destroy = true
    ignore_changes        = ["subnet_id"]
  }

  depends_on  = ["aws_eip.nat_eip"]
}
