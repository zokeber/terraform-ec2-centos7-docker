resource "aws_security_group" "default" {
  name        = "internal"
  description = "Default security group that allows inbound and outbound traffic from all instances in the VPC"
  vpc_id      = "${var.vpc_id}"
  tags        = "${merge(map("Name", "${var.name}-${var.env}-sg-default"), var.tags)}"
}


resource "aws_security_group_rule" "internal_ingress" {
  type              = "ingress"
  from_port         = "0"
  to_port           = "0"
  protocol          = "-1"
  self              = true
  security_group_id = "${aws_security_group.default.id}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "internal_egress" {
  type              = "egress"
  from_port         = "0"
  to_port           = "0"
  protocol          = "-1"
  self              = true
  security_group_id = "${aws_security_group.default.id}"

  lifecycle {
    create_before_destroy = true
  }
}

###

resource "aws_security_group" "nat" {
  name        = "nat"
  description = "security group that allows all inbound and outbound traffic. should only be applied to instances in a private subnet"
  vpc_id      = "${var.vpc_id}"
  tags        = "${merge(map("Name", "${var.name}-${var.env}-sg-nat"), var.tags)}"
  #depends_on  = ["aws_nat_gateway.nat_gw"]
}

resource "aws_security_group_rule" "nat_ingress" {
  type              = "ingress"
  from_port         = "0"
  to_port           = "0"
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.nat.id}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "nat_egress" {
  type              = "egress"
  from_port         = "0"
  to_port           = "0"
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.nat.id}"

  lifecycle {
    create_before_destroy = true
  }
}

### 

resource "aws_security_group" "ec2_simple" {
  name        = "ec2_simple"
  description = "security group that allows all inbound and outbound traffic. should only be applied to instances in a private subnet"
  vpc_id      = "${var.vpc_id}"
  tags        = "${merge(map("Name", "${var.name}-${var.env}-sg-ec2_simple"), var.tags)}"
  #depends_on  = ["aws_nat_gateway.nat_gw"]
}

resource "aws_security_group_rule" "ec2_ingress_shh" {
  type              = "ingress"
  from_port         = "0"
  to_port           = "0"
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.ec2_simple.id}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "ec2_egress_ssh" {
  type              = "egress"
  from_port         = "0"
  to_port           = "0"
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.ec2_simple.id}"

  lifecycle {
    create_before_destroy = true
  }
}


###

resource "aws_security_group" "ec2_multiple" {
  
  name        = "ec2_multiple"
  description = "security group that allows all inbound and outbound traffic. should only be applied to instances in a private subnet"
  vpc_id      = "${var.vpc_id}"
  tags        = "${merge(map("Name", "${var.name}-${var.env}-sg-ec2_multiple"))}"

  #Ingresses:
  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Egresses:
  egress {
    protocol    = -1
    from_port   = 0 
    to_port     = 0 
    cidr_blocks = ["0.0.0.0/0"]
  }

}

