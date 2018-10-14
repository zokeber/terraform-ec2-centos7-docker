resource "aws_route_table" "public" {
  vpc_id = "${var.vpc_id}"
  tags   = "${merge(map("Name", "${var.name}-rt-public"), var.tags)}"
}

resource "aws_route" "internet_route" {
  route_table_id         = "${aws_route_table.public.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${var.internet_gateway_id}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route_table_association" "public" {
  count          = "${length(var.azs)}"
  subnet_id      = "${var.public_subnet_ids[count.index]}"
  route_table_id = "${aws_route_table.public.id}"

  lifecycle {
    ignore_changes        = ["subnet_id", "route_table_id"]
    create_before_destroy = true
  }
}
