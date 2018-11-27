output "vpc_id" {
  value = "${module.vpc.vpc_id}"
}

output "public_subnets" {
  value = "${module.public_subnets.public_subnet_ids}"
}

output "availability_zones" {
  value = "${module.public_subnets.availability_zones}"
}

output "nat_gateway_ids" {
  value = "${module.public_subnets.nat_gateway_ids}"
}

output "private_subnets" {
  value = "${module.private_subnets.private_subnet_ids}"
}

output "name" {
  value = "${var.name}"
}

output "instance_name" {
  value = "${var.name}"
}

output "region" {
  value = "${var.region}"
}

output "ami" {
  value = "${lookup(var.amis, var.region)}"
}

output "ec2_public_ip" {
  value = "${aws_instance.ec2.public_ip}"
}

output "elastic_ip" {
  value = "${aws_eip.elastic_ip.*.public_ip}"
}

output "user" {
  value = "${var.user_connection}"
}

