variable "aws_region" {
  description = "AWS region where resources will be created"
  type        = string
  default     = "eu-west-1"
}

variable "domain_name" {
  description = "The domain name to manage DNS records for"
  type        = string
  default     = "clockshire.uk"
}

variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
  default     = "prod"
}

variable "aws_account_id" {
  description = "AWS Account ID"
  type        = string
}
