output "domain_name" {
  description = "The domain name being managed"
  value       = var.domain_name
}

output "hosted_zone_id" {
  description = "The Route 53 hosted zone ID"
  value       = data.aws_route53_zone.main.zone_id
}

output "name_servers" {
  description = "The name servers for the hosted zone"
  value       = data.aws_route53_zone.main.name_servers
}

output "mx_record" {
  description = "The MX record for email"
  value       = aws_route53_record.mx.fqdn
}

output "txt_record" {
  description = "The SPF TXT record"
  value       = aws_route53_record.txt.fqdn
}

output "dkim_records" {
  description = "The DKIM CNAME records for email authentication"
  value = {
    dkim1 = aws_route53_record.dkim1.fqdn
    dkim2 = aws_route53_record.dkim2.fqdn
    dkim3 = aws_route53_record.dkim3.fqdn
  }
}

output "terraform_state_bucket" {
  description = "The S3 bucket used for Terraform state storage"
  value       = aws_s3_bucket.terraform_state.bucket
}

output "terraform_locks_table" {
  description = "The DynamoDB table used for Terraform state locking"
  value       = aws_dynamodb_table.terraform_locks.name
}
