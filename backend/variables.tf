# AWS region where backend resources (S3, DynamoDB) will be created
variable "region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "ap-south-1" # Default region can be changed as needed
}

# Name of the S3 bucket that will store the Terraform state files
variable "s3_bucket_name" {
  description = "Name of the S3 bucket to store Terraform state"
  type        = string
  default     = "apinfra-terraform-eks-state-bucket"
}

# Name of the DynamoDB table that will be used for Terraform state locking
variable "dynamodb_table_name" {
  description = "Name of the DynamoDB table for state locking"
  type        = string
  default     = "apinfra-terraform-eks-state-lock-table"
}
# Hash key for the DynamoDB table used for state locking
variable "dynamodb_hash_key" {
  description = "Hash key for the DynamoDB table"
  type        = string
  default     = "LockID"
}