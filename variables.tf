## If you change this variable, You have to change in your AWS credential file:
variable "name" {
  default = "docker-server"
}

variable "region" {
  default = "us-east-2"
}

variable "azs" {
  default = ["us-east-2a"]
  type    = "list"
}

variable "env" {
  default = "prod"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "volume_size" {
  default = 10
}

variable "aws_type" {
  default = "t3.small"
}

variable "user_connection" {
  type = "string"
  default = "centos"
}

variable "key_pub" {
  default = "id_rsa.pub"
}

variable "key_private" {
  default = "id_rsa"
}

variable "key_path" {
  default = "~/.ssh"
}

variable "my_ip_home" {
  default = "192.168.10.5/32"
}

variable "my_ip_office" {
  default = "192.168.11.5/32"
}

variable "elastic_ip" {
  default = false
}

variable "enable_nat_gateway" {
  default = false
}


##
## Get AMI ID for CentOS 7:
## aws --region us-east-2 ec2 describe-images --owners aws-marketplace --filters Name=product-code,Values=aw0evgkw8e5c1q413zgy5pjce
variable "amis" {
  type = "map"
  default = {
    "us-east-1" = "ami-NNNNNNNN",
    "us-east-2" = "ami-NNNNNNNN"
  }
}

