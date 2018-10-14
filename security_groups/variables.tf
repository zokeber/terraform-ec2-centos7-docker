variable "name" {}

variable "env" {}

variable "vpc_id" {}

variable "tags" {
  type    = "map"
  default = {}
}