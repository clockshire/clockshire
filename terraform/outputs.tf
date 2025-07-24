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
