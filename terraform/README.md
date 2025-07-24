# Terraform DNS Management for Clockshire

This Terraform configuration manages DNS records for the `clockshire.uk` domain
using AWS Route 53.

## Prerequisites

1. **AWS CLI configured** with appropriate credentials
2. **Terraform installed** (version >= 1.0)
3. **Route 53 hosted zone** already exists for `clockshire.uk`
4. **S3 bucket and DynamoDB table** for state management (see Backend Setup below)

## Current DNS Records Managed

- **MX Record**: `10 mailserver.purelymail.com.` (for email)
- **SPF TXT Record**: `v=spf1 include:_spf.purelymail.com ~all` (email authentication)
- **PurelyMail Ownership TXT Record**: Proof of domain ownership for PurelyMail

## Usage

### Backend Setup

1. **Migrate to S3 backend:**

   ```bash
   ./migrate-to-s3.sh
   ```

   This script will:

   - Initialize with local backend
   - Create S3 bucket and DynamoDB table
   - Guide you through migrating to remote backend

   **Note**: The bucket name must be globally unique. If it already exists,
   edit `s3.tf` and `main.tf` with a different name.

### Initial Setup

1. **Copy the example variables file:**

   ```bash
   cp terraform.tfvars.example terraform.tfvars
   ```

2. **Review and modify `terraform.tfvars` if needed**

3. **Initialise Terraform with state migration:**

   ```bash
   terraform init -migrate-state
   ```

### Plan and Apply

1. **Review the planned changes:**

   ```bash
   terraform plan
   ```

2. **Apply the configuration:**

   ```bash
   terraform apply
   ```

3. **Review the outputs:**

   ```bash
   terraform output
   ```

### Making Changes

1. **Edit the Terraform files** as needed
2. **Run `terraform plan`** to see what will change
3. **Run `terraform apply`** to apply changes

### Adding New DNS Records

To add new DNS records, add new `aws_route53_record` resources to `main.tf`.
For example:

```hcl
resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = "www.${var.domain_name}"
  type    = "A"
  ttl     = 300

  records = ["192.168.1.1"]
}
```

## Important Notes

- **NS and SOA records** are managed by AWS and should not be modified manually
- **TTL values** are set to match your current configuration
- **PurelyMail records** are included for email service integration

## Security

- Never commit `terraform.tfvars` to version control if it contains sensitive information
- Use AWS IAM roles with minimal required permissions
- Consider using Terraform Cloud or similar for state management in production

## Troubleshooting

- **"Hosted zone not found"**: Ensure the Route 53 hosted zone exists for `clockshire.uk`
- **"Access denied"**: Check AWS credentials and IAM permissions
- **"Record already exists"**: Terraform will manage existing records, but
  conflicts may occur if records were created outside of Terraform
