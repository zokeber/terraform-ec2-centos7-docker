variable "name" {}

variable "env" {}

variable "vpc_id" {}

variable "tags" {
  type    = "map"
  default = {}
}

variable "allow_ip_address" {
   default = []
}