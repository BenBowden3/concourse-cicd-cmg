provider "aws" {
  region     = "us-east-1"
  version = "~> 2.7"
}

data "aws_region" "current" {}
//data "aws_caller_identity" "current" {}