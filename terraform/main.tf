terraform {
  required_version = ">= 1.12"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.45"
    }
  }

  backend "s3" {
    bucket         = "436158765452-clockshire-terraform-state"
    key            = "dns/terraform.tfstate"
    region         = "eu-west-2"
    encrypt        = true
    dynamodb_table = "436158765452-clockshire-terraform-locks"
  }
}

provider "aws" {
  region = var.aws_region
}
