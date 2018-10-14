variable "name" {}

variable "vpc_cidr" {}

variable "tags" {
  type    = "map"
  default = {}
}
