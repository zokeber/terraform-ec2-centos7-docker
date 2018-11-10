variable "name" {}

variable "vpc_id" {}

variable "private_subnet_ids" {
  type = "list"
}

variable "nat_gateway_ids" {
  type = "list"
}

variable "azs" {
  type = "list"
}

variable "tags" {
  type    = "map"
  default = {}
}

variable "enable_nat_gateway" {}