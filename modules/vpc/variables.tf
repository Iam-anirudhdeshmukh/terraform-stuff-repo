# CIDR block for the VPC (e.g., "10.0.0.0/16")
variable "vpc_cidr" {
  description = "The CIDR block for the VPC in which all networking components will be provisioned"
  type        = string
}

# Availability Zones to distribute subnets across (e.g., ["ap-south-1a", "ap-south-1b", "ap-south-1c"])
variable "availability_zones" {
  description = "List of AWS availability zones to deploy subnets into"
  type        = list(string)
}

# CIDR blocks for the private subnets (e.g., ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"])
variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for the private subnets associated with each availability zone"
  type        = list(string)
}

# CIDR blocks for the public subnets (e.g., ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"])
variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for the public subnets associated with each availability zone"
  type        = list(string)
}

# Cluster name for tagging and resource identification (e.g., "dev-eks")
variable "cluster_name" {
  description = "Name of the EKS cluster, used for tagging networking resources"
  type        = string
}
