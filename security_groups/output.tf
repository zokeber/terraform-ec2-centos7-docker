output "sg_ec2_simple_id" {
  value = "${aws_security_group.ec2_simple.id}"
}

output "sg_ec2_multiple_id" {
  value = "${aws_security_group.ec2_multiple.id}"
}