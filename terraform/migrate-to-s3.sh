#!/bin/bash

# Script to migrate from local backend to S3 backend

echo "Step 1: Initializing with local backend..."
terraform init

echo ""
echo "Step 2: Creating S3 bucket and DynamoDB table..."
terraform apply -target=aws_s3_bucket.terraform_state -target=aws_s3_bucket_versioning.terraform_state -target=aws_s3_bucket_server_side_encryption_configuration.terraform_state -target=aws_s3_bucket_public_access_block.terraform_state -target=aws_dynamodb_table.terraform_locks

echo ""
echo "Step 3: Uncommenting S3 backend configuration in main.tf..."
echo "Please manually uncomment the backend configuration in main.tf, then run:"
echo "terraform init -migrate-state"

echo ""
echo "Step 4: After migration, you can apply the full configuration:"
echo "terraform apply"
