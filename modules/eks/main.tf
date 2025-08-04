# IAM Role for EKS Control Plane
resource "aws_iam_role" "eks_control_plane_role" {
  name = "${var.cluster_name}-eks-control-plane-role"

  # This trust policy allows EKS to assume this role to manage the control plane
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "eks.amazonaws.com"
      }
    }]
  })
}

# Attach the AmazonEKSClusterPolicy to the control plane role
resource "aws_iam_role_policy_attachment" "eks_control_plane_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_control_plane_role.name
}

# EKS Cluster Resource
resource "aws_eks_cluster" "eks_cluster" {
  name     = var.cluster_name
  version  = var.cluster_version
  role_arn = aws_iam_role.eks_control_plane_role.arn

  # Associate the cluster with the provided VPC subnets
  vpc_config {
    subnet_ids = var.subnet_ids
  }

  # Ensure IAM role and policy are created before provisioning the cluster
  depends_on = [
    aws_iam_role_policy_attachment.eks_control_plane_policy_attachment
  ]
}

# IAM Role for EC2 Worker Nodes (Node Group)
resource "aws_iam_role" "eks_node_group_role" {
  name = "${var.cluster_name}-eks-node-group-role"

  # This trust policy allows EC2 instances to assume this role (required for worker nodes)
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

# Attach required policies to the worker node role
resource "aws_iam_role_policy_attachment" "eks_node_group_policy_attachments" {
  for_each = toset([
    # Provides access to manage worker nodes within EKS
    "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",

    # Provides networking permissions for EKS CNI
    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",

    # Allows pulling container images from Amazon ECR
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  ])

  policy_arn = each.value
  role       = aws_iam_role.eks_node_group_role.name
}

# EKS Node Group Configuration
resource "aws_eks_node_group" "eks_node_groups" {
  for_each = var.node_groups

  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = each.key
  node_role_arn   = aws_iam_role.eks_node_group_role.arn
  subnet_ids      = var.subnet_ids

  instance_types = each.value.instance_types
  capacity_type  = each.value.capacity_type

  scaling_config {
    desired_size = each.value.scaling_config.desired_size
    max_size     = each.value.scaling_config.max_size
    min_size     = each.value.scaling_config.min_size
  }

  # Ensure IAM policies are attached before provisioning node group
  depends_on = [
    aws_iam_role_policy_attachment.eks_node_group_policy_attachments
  ]
}
