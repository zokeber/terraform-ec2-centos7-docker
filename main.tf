module "vpc" {
  source   = "./vpc"
  name     = "${var.name}"
  vpc_cidr = "${var.vpc_cidr}"

  tags {
    Terraformed = "true"
  }
}

module "public_subnets" {
  source         = "./public_subnets"
  name           = "${var.name}"
  env            = "${var.env}"
  vpc_id         = "${module.vpc.vpc_id}"
  azs            = "${var.azs}"
  public_sn_cidr = "${cidrsubnet(var.vpc_cidr, 2, 0)}"

  tags {
    Terraformed = "true"
  }
}

module "private_subnets" {
  source          = "./private_subnets"
  name            = "${var.name}"
  env            = "${var.env}"
  vpc_id          = "${module.vpc.vpc_id}"
  azs             = "${var.azs}"
  private_sn_cidr = "${cidrsubnet(var.vpc_cidr, 2, 2)}"

  tags {
    Terraformed = "true"
  }
}

module "public-route-table" {
  source              = "./public-route-table"
  name                = "${var.name}"
  vpc_id              = "${module.vpc.vpc_id}"
  internet_gateway_id = "${module.vpc.internet_gateway_id}"
  public_subnet_ids   = "${module.public_subnets.public_subnet_ids}"
  azs                 = "${var.azs}"

  tags {
    Terraformed = "true"
  }
}

module "private-route-table" {
  source             = "./private-route-table"
  name               = "${var.name}"
  vpc_id             = "${module.vpc.vpc_id}"
  private_subnet_ids = "${module.private_subnets.private_subnet_ids}"
  nat_gateway_ids    = "${module.public_subnets.nat_gateway_ids}"
  azs                = "${var.azs}"

  tags {
    Terraformed = "true"
  }
}

module "security_groups" {
  source              = "./security_groups"
  name                = "${var.name}"
  env                 = "${var.env}"
  vpc_id              = "${module.vpc.vpc_id}"
  allow_ip_address    = ["${var.my_ip_home}", "${var.my_ip_office}"]

  tags {
    Terraformed = "true"
  }
}

resource "aws_key_pair" "ssh_key_pub" {
   key_name = "${var.name}"
   public_key = "${file("${var.key_path}/${var.key_pub}")}"
}

resource "aws_instance" "ec2" {

  instance_type               = "${var.aws_type}"
  ami                         = "${lookup(var.amis, var.region)}"
  key_name                    = "${aws_key_pair.ssh_key_pub.key_name}"
  subnet_id                   = "${module.public_subnets.public_subnet_id}"
  associate_public_ip_address = true

  vpc_security_group_ids      = ["${module.security_groups.sg_ec2_multiple_id}"]

  root_block_device {
    volume_type               = "gp2"
    volume_size               = "${var.volume_size}"
    delete_on_termination     = "true"
  }

  provisioner "file" {
    source      = "script.sh"
    destination = "/tmp/script.sh"

    connection {
      user        = "centos"
      host        = "${aws_instance.ec2.public_ip}"
      agent       = false
      private_key = "${file("${var.key_path}/${var.key_private}")}"
    }
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script.sh",
      "/tmp/script.sh",
    ]

    connection {
      user        = "${var.user_connection}"
      host        = "${aws_instance.ec2.public_ip}"
      agent       = false
      private_key = "${file("${var.key_path}/${var.key_private}")}"
    }

  }

  tags {
    Name        = "${var.name}"
    Environment = "${var.env}"
    Terraformed = "true"
  }

}

resource "aws_eip" "elastic_ip" {
  count    = "${var.elastic_ip ? 1 : 0}" 
  instance = "${aws_instance.ec2.id}"
  vpc      = true
}

