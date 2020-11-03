variable "environment" {
  type = string
}

variable "serviceName" {
  type = string
}

variable "region" {
  type = string
}

variable "allowedAccountIds" {
  type = list
}

variable "roleArn" {
  type = string
}

variable "tfStateKey" {
  type = string
}

variable "stateBucket" {
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
