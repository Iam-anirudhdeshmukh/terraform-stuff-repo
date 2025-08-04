# main.tf
# This file configures the backend resources for Terraform state management on AWS.

# Configure the AWS provider
provider "aws" {
  region = "ap-south-1"
}

# S3 bucket to store Terraform state files
resource "aws_s3_bucket" "my_bucket" {
  bucket = "apinfra-terraform-eks-state-bucket"

  lifecycle {
    prevent_destroy = false
  }
}

# DynamoDB table for state locking and consistency
resource "aws_dynamodb_table" "my_bucket_lock" {
  name         = "apinfra-terraform-eks-state-lock-table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
