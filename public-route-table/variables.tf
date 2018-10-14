variable "name" {}

variable "vpc_id" {}

variable "internet_gateway_id" {}

variable "public_subnet_ids" {
  type = "list"
}

variable "tags" {
  type    = "map"
  default = {}
}

variable "azs" {
  type = "list"
}
