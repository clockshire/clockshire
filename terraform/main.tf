terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# Data source to get the hosted zone
data "aws_route53_zone" "main" {
  name = var.domain_name
}

# NS Records (these are typically managed by AWS and shouldn't be changed manually)
# The NS records shown in your DNS output are AWS-managed and should remain as-is

# SOA Record (also typically managed by AWS)
# The SOA record shown in your DNS output is AWS-managed and should remain as-is

# MX Record for email
resource "aws_route53_record" "mx" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = var.domain_name
  type    = "MX"
  ttl     = 3600

  records = [
    "10 mailserver.purelymail.com"
  ]
}

# TXT Record
resource "aws_route53_record" "txt" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = var.domain_name
  type    = "TXT"
  ttl     = 3600

  records = [
    "v=spf1 include:_spf.purelymail.com ~all",
    "purelymail_ownership_proof=2954580cef1b21ff01add827dbe549028d41ce109e2ddd2bd46b884a4df9af7e724e053d1202bf1eb12a83c05fe6f05b05bc2d9d24f91f1f7026f930ab50e0f9"
  ]
}

# DKIM Records for PurelyMail email authentication
resource "aws_route53_record" "dkim1" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = "purelymail1._domainkey.${var.domain_name}"
  type    = "CNAME"
  ttl     = 3600

  records = [
    "key1.dkimroot.purelymail.com."
  ]
}

resource "aws_route53_record" "dkim2" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = "purelymail2._domainkey.${var.domain_name}"
  type    = "CNAME"
  ttl     = 3600

  records = [
    "key2.dkimroot.purelymail.com."
  ]
}

resource "aws_route53_record" "dkim3" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = "purelymail3._domainkey.${var.domain_name}"
  type    = "CNAME"
  ttl     = 3600

  records = [
    "key3.dkimroot.purelymail.com."
  ]
}
