variable "environment" {
  type = string
}

variable "serviceName" {
  type = string
}

variable "region" {
  type = string
}
variable "uniqueid" {
  type = string
  default = "fmr"
}

locals {
  tags = {}
  name = "${var.serviceName}"
  prefix = "${var.environment}-${var.serviceName}"
  lambda_memory = 128
}
