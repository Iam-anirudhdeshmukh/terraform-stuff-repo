# Name of the Amazon EKS cluster (e.g., "dev-cluster")
variable "cluster_name" {
  description = "Unique name to identify the EKS cluster"
  type        = string
}

# Kubernetes version to deploy (e.g., "1.29")
variable "cluster_version" {
  description = "Kubernetes version for the EKS control plane"
  type        = string
}

# ID of the VPC in which the EKS cluster and node groups will reside
variable "vpc_id" {
  description = "VPC ID where EKS cluster resources will be provisioned"
  type        = string
}

# List of subnet IDs used for the EKS control plane and worker nodes
variable "subnet_ids" {
  description = "List of subnet IDs for EKS cluster networking"
  type        = list(string)
}

# Map of EKS managed node group configurations, keyed by group name
# Example:
# node_groups = {
#   "ng-1" = {
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
  description = "Map of EKS managed node group configurations, keyed by node group name"
  type = map(object({
    instance_types = list(string)  # EC2 instance types for the nodes
    capacity_type  = string        # ON_DEMAND or SPOT
    scaling_config = object({
      desired_size = number        # Desired number of worker nodes
      max_size     = number        # Maximum number of worker nodes
      min_size     = number        # Minimum number of worker nodes
    })
  }))
}