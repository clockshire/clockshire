#!/bin/bash

# Script to import existing Route 53 DNS records into Terraform state

echo "Getting hosted zone ID for clockshire.uk..."
# shellcheck disable=SC2016
ZONE_ID=$(aws route53 list-hosted-zones --query 'HostedZones[?Name==`clockshire.uk.`].Id' --output text | sed 's/\/hostedzone\///')

if [ -z "$ZONE_ID" ]; then
    echo "Error: Could not find hosted zone for clockshire.uk"
    exit 1
fi

echo "Found hosted zone ID: $ZONE_ID"
echo ""

echo "Importing existing DNS records..."

# Import MX record
echo "Importing MX record..."
terraform import aws_route53_record.mx "${ZONE_ID}_clockshire.uk_MX"

# Import TXT record (contains both SPF and PurelyMail ownership)
echo "Importing TXT record..."
terraform import aws_route53_record.txt "${ZONE_ID}_clockshire.uk_TXT"

# Import DKIM records
echo "Importing DKIM records..."
terraform import aws_route53_record.dkim1 "${ZONE_ID}_purelymail1._domainkey.clockshire.uk_CNAME"
terraform import aws_route53_record.dkim2 "${ZONE_ID}_purelymail2._domainkey.clockshire.uk_CNAME"
terraform import aws_route53_record.dkim3 "${ZONE_ID}_purelymail3._domainkey.clockshire.uk_CNAME"

echo ""
echo "Import completed. Run 'terraform plan' to verify everything is in sync."
