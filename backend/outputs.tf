# Output the name of the created S3 bucket for Terraform state storage
output "s3_bucket_name" {
  description = "Name of the S3 bucket created for Terraform state"
  value       = aws_s3_bucket.my_bucket.bucket
}

# Output the name of the created DynamoDB table for Terraform state locking
output "dynamodb_table_name" {
  description = "Name of the DynamoDB table created for Terraform state locking"
  value       = aws_dynamodb_table.my_bucket_lock.name
}
# Output the ARN of the created DynamoDB table for Terraform state locking
output "dynamodb_table_arn" {
  description = "ARN of the DynamoDB table created for Terraform state locking"
  value       = aws_dynamodb_table.my_bucket_lock.arn
}