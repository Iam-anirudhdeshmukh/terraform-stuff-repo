############################
# Terraform Settings
############################

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0" # Use AWS provider version 5.x
    }
  }

  # Remote backend for state management and locking
  backend "s3" {
    bucket         = "apinfra-terraform-eks-state-bucket"     # S3 bucket for storing state file
    key            = "terraform.tfstate"                      # Path/key within the S3 bucket
    region         = "ap-south-1"                             # Region for S3 and DynamoDB resources
    dynamodb_table = "apinfra-terraform-eks-state-lock-table" # DynamoDB table for state locking
    encrypt        = true                                     # Enable server-side encryption
  }
}

############################
# AWS Provider Configuration
############################

provider "aws" {
  region = var.region # Region is passed via variable for flexibility
}

############################
# VPC Module
############################

module "vpc" {
  source = "./modules/vpc"

  cluster_name         = var.cluster_name
  vpc_cidr             = var.vpc_cidr
  availability_zones   = var.availability_zones
  private_subnet_cidrs = var.private_subnet_cidrs
  public_subnet_cidrs  = var.public_subnet_cidrs
}

############################
# EKS Module
############################

module "eks" {
  source = "./modules/eks"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version
  vpc_id          = module.vpc.vpc_id
  subnet_ids      = module.vpc.private_subnet_ids # Only private subnets used for worker nodes
  node_groups     = var.node_groups
}
