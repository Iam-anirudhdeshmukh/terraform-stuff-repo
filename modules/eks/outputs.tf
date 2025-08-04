# Output the API server endpoint of the EKS cluster
output "cluster_endpoint" {
  description = "URL endpoint for the EKS Kubernetes API server"
  value       = aws_eks_cluster.eks_cluster.endpoint
}

# Output the name of the EKS cluster
output "cluster_name" {
  description = "Name of the EKS cluster"
  value       = aws_eks_cluster.eks_cluster.name
}
