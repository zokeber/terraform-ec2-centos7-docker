output "vpc_id" {
  value = "${aws_vpc.default.id}"
}

output "vpc_cidr" {
  value = "${aws_vpc.default.cidr_block}"
}

output "internet_gateway_id" {
  value = "${aws_internet_gateway.default.id}"
}
