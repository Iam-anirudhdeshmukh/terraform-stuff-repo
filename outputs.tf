# EKS Cluster Outputs
output "cluster_name" {
  description = "Name of the EKS cluster"
  value       = module.eks.cluster_name
}

output "cluster_endpoint" {
  description = "URL of the EKS Kubernetes API server"
  value       = module.eks.cluster_endpoint
}

# VPC & Networking Outputs
output "vpc_id" {
  description = "ID of the VPC used for EKS and other resources"
  value       = module.vpc.vpc_id
}

output "private_subnet_ids" {
  description = "List of private subnet IDs created in the VPC"
  value       = module.vpc.private_subnet_ids
}

output "public_subnet_ids" {
  description = "List of public subnet IDs created in the VPC"
  value       = module.vpc.public_subnet_ids
}
