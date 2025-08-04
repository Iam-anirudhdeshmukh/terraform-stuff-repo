# main.tf
# This file configures the backend resources for Terraform state management on AWS.

# Configure the AWS provider using region variable
provider "aws" {
  region = var.region
}

# S3 bucket to store Terraform state files
resource "aws_s3_bucket" "my_bucket" {
  bucket = var.s3_bucket_name

  lifecycle {
    prevent_destroy = false
  }
}

# DynamoDB table for state locking and consistency
resource "aws_dynamodb_table" "my_bucket_lock" {
  name         = var.dynamodb_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
# Enable versioning on the S3 bucket for state files
resource "aws_s3_bucket_versioning" "my_bucket_versioning" {
  bucket = aws_s3_bucket.my_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}