output "public_subnet_ids" {
  value = ["${aws_subnet.public.*.id}"]
}

output "public_subnet_id" {
  value = "${aws_subnet.public.*.id[0]}" # Fix!
}

output "nat_gateway_ids" {
  value = ["${aws_nat_gateway.nat_gw.*.id}"]
}

output "availability_zones" {
  value = "${var.azs}"
}