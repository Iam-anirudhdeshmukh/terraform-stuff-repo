# AWS Region to deploy all resources into
variable "region" {
  description = "AWS region where all resources will be deployed"
  type        = string
  default     = "ap-south-1"
}

# CIDR block for the VPC
variable "vpc_cidr" {
  description = "CIDR block for the VPC (e.g., 10.0.0.0/16)"
  type        = string
  default     = "10.0.0.0/16"
}

# List of availability zones to span the subnets across
variable "availability_zones" {
  description = "List of availability zones to use for subnets"
  type        = list(string)
  default     = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
}

# CIDR blocks for private subnets, mapped 1:1 with availability_zones
variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for private subnets (aligned with AZs)"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

# CIDR blocks for public subnets, mapped 1:1 with availability_zones
variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets (aligned with AZs)"
  type        = list(string)
  default     = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
}

# Name of the EKS cluster (used for tagging and resource naming)
variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "my-eks-cluster"
}

# Desired Kubernetes version for the EKS control plane
variable "cluster_version" {
  description = "Kubernetes version for the EKS control plane"
  type        = string
  default     = "1.30"
}

# Configuration for EKS managed node groups
# Example:
# node_groups = {
#   general = {
#     instance_types = ["t3.medium"]
#     capacity_type  = "ON_DEMAND"
#     scaling_config = {
#       desired_size = 2
#       max_size     = 4
#       min_size     = 1
#     }
#   }
# }
variable "node_groups" {
  description = "Map of EKS node group configurations, keyed by group name"
  type = map(object({
    instance_types = list(string)  # List of EC2 instance types to use
    capacity_type  = string        # Can be ON_DEMAND or SPOT
    scaling_config = object({
      desired_size = number        # Desired number of nodes
      max_size     = number        # Maximum number of nodes
      min_size     = number        # Minimum number of nodes
    })
  }))
  default = {
    general = {
      instance_types = ["t3.micro"]
      capacity_type  = "ON_DEMAND"
      scaling_config = {
        desired_size = 2
        max_size     = 4
        min_size     = 1
      }
    }
  }
}
