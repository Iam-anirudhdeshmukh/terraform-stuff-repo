
# 🚀 Terraform AWS VPC & EKS Infrastructure Setup

This project automates the provisioning of a complete AWS infrastructure using [Terraform](https://www.terraform.io/). It includes:

- 🔧 VPC with public/private subnets across multiple AZs
- 🧭 NAT gateways, route tables, and internet gateway
- ☸️ Amazon EKS cluster with managed node groups
- 📦 Remote state backend using S3 and DynamoDB
- 🧩 Modular structure for reuse and scalability

---

## 📁 Repository Structure

terraform-stuff-repo/
├── backend/                   # Backend configuration (S3 + DynamoDB)
│   └── main.tf
├── modules/                   # Terraform modules
│   ├── eks/                   # EKS module
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   └── notes
│   └── vpc/                   # VPC module
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
├── main.tf                    # Root configuration
├── variables.tf               # Input variables
├── outputs.tf                 # Output values
├── terraform.tfstate          # Local state (ignored by Git)
├── terraform.tfstate.backup
├── .gitignore
└── README.md


---

## Terraform Backend Setup for EKS State Management

This Terraform configuration creates the necessary AWS resources to store and lock the Terraform state securely for your EKS infrastructure setup.

### Overview

- **S3 Bucket:** `apinfra-terraform-eks-state-bucket` — Stores the Terraform state files.  
- **DynamoDB Table:** `apinfra-terraform-eks-state-lock-table` — Used for state locking and consistency to prevent concurrent changes.

### Resources Created

| Resource Type      | Name                                      | Purpose                                  |
|--------------------|-------------------------------------------|------------------------------------------|
| AWS S3 Bucket      | `apinfra-terraform-eks-state-bucket`     | Remote storage of Terraform state files. |
| AWS DynamoDB Table | `apinfra-terraform-eks-state-lock-table` | Locking mechanism to avoid concurrent runs.|

### Usage Instructions

#### Prerequisites

- AWS CLI configured with appropriate credentials and permissions.
- Terraform installed (version compatible with AWS provider v5.x).
- Permissions to create S3 buckets and DynamoDB tables.

#### Steps

1. Clone the repository:
   ```bash
   git clone https://github.com/your-org/terraform-stuff-repo.git
   cd terraform-stuff-repo

## How to Initialize and Apply Terraform Backend

### Step 1: Initialize Terraform

This command initializes the Terraform working directory, downloads the necessary provider plugins, and configures the backend.

terraform init

## Step 2: Apply the Backend Infrastructure
This command applies the Terraform configuration to create the backend resources such as the S3 bucket and DynamoDB table for state management.


terraform apply

Note: Review the plan output and confirm the apply to provision resources.