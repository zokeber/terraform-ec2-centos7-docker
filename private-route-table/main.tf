data "aws_availability_zone" "az" {
  count = "${length(var.azs)}"
  name  = "${var.azs[count.index]}"
}

resource "aws_route_table" "private" {
  count  = "${length(var.azs)}"
  vpc_id = "${var.vpc_id}"
  tags   = "${merge(map("Name", "${var.name}-rt-private-${data.aws_availability_zone.az.*.name_suffix[count.index]}"), var.tags)}"
}

resource "aws_route" "nat_route" {
  count                  = "${var.enable_nat_gateway ? length(var.azs) : 0}"
  route_table_id         = "${aws_route_table.private.*.id[count.index]}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${var.nat_gateway_ids[count.index]}"

  lifecycle {
    create_before_destroy = true
    ignore_changes        = ["route_table_id", "nat_gateway_id"]
  }
}

resource "aws_route_table_association" "private" {
  count          = "${var.enable_nat_gateway ? length(var.azs) : 0}"
  subnet_id      = "${var.private_subnet_ids[count.index]}"
  route_table_id = "${aws_route_table.private.*.id[count.index]}"

  lifecycle {
    ignore_changes        = ["subnet_id"]
    create_before_destroy = true
  }
}
