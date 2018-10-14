variable "name" {}

variable "env" {}

variable "vpc_id" {}

variable "azs" {
  type = "list"
}

variable "public_sn_cidr" {}

variable "tags" {
  type    = "map"
  default = {}
}
