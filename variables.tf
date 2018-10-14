variable "name" {
  default = "docker-server"
}

variable "region" {
  default = "us-east-2"
}

variable "azs" {
  default = ["us-east-2a", "us-east-2b", "us-east-2c"]
  type    = "list"
}

variable "env" {
  default = "prod"
}

variable "vpc_cidr" {
  default = "10.100.0.0/16"
}

variable "volume_size" {
  default = 100
}

variable "aws_type" {
  default = "t2.small"
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
  default = "/home/zokeber/.ssh"
}

##
## Get AMI ID for CentOS 7:
## aws --region us-east-2 ec2 describe-images --owners aws-marketplace --filters Name=product-code,Values=aw0evgkw8e5c1q413zgy5pjceOA
variable "amis" {
  type = "map"
  default = {
    "us-east-1" = "ami-b374d5a5", #CentOS 7
    "us-east-2" = "ami-9c0638f9" #CentOS 7 (x86_64) - with Updates HVM - Software Version: 1805_01
  }
}

