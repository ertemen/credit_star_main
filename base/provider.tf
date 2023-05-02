terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "3.70.0"
    }
  }
}

provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {}
}

data "aws_caller_identity" "current" {}