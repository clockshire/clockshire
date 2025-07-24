#!/bin/bash

# Script to import existing Route 53 DNS records into Terraform state

echo "Getting hosted zone ID for clockshire.uk..."
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

# Import SPF TXT record
echo "Importing SPF TXT record..."
terraform import aws_route53_record.spf "${ZONE_ID}_clockshire.uk_TXT"

# Import PurelyMail ownership TXT record
echo "Importing PurelyMail ownership TXT record..."
terraform import aws_route53_record.purelymail_ownership "${ZONE_ID}_clockshire.uk_TXT"

echo ""
echo "Import completed. Run 'terraform plan' to verify everything is in sync." 
