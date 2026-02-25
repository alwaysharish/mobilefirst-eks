# outputs.tf - Output Values

output "cluster_id" {
  description = "The name/id of the EKS cluster"
  value       = aws_eks_cluster.main.id
}

output "cluster_arn" {
  description = "The ARN of the EKS cluster"
  value       = aws_eks_cluster.main.arn
}

output "cluster_endpoint" {
  description = "Endpoint for EKS control plane"
  value       = aws_eks_cluster.main.endpoint
}

output "cluster_version" {
  description = "The Kubernetes version for the cluster"
  value       = aws_eks_cluster.main.version
}

output "cluster_certificate_authority_data" {
  description = "Base64 encoded certificate data required to communicate with the cluster"
  value       = aws_eks_cluster.main.certificate_authority[0].data
  sensitive   = true
}

output "cluster_oidc_issuer_url" {
  description = "The URL on the EKS cluster OIDC Issuer"
  value       = try(aws_eks_cluster.main.identity[0].oidc[0].issuer, "")
}

output "microservices_node_group_id" {
  description = "EKS microservices node group ID"
  value       = aws_eks_node_group.microservices.id
}

output "microservices_node_group_arn" {
  description = "ARN of the microservices EKS node group"
  value       = aws_eks_node_group.microservices.arn
}

output "microservices_node_group_status" {
  description = "Status of the microservices EKS node group"
  value       = aws_eks_node_group.microservices.status
}

output "configure_kubectl" {
  description = "Command to configure kubectl"
  value       = "aws eks update-kubeconfig --region ${var.aws_region} --name ${aws_eks_cluster.main.name}"
}

output "vpc_id" {
  description = "VPC ID used by the cluster"
  value       = var.vpc_id
}

output "private_subnets" {
  description = "Private subnet IDs used by the cluster"
  value       = aws_subnet.private[*].id
}

output "eks_oidc_provider_arn" {
  description = "OIDC Provider ARN for IRSA"
  value       = aws_iam_openid_connect_provider.eks.arn
}


output "eks_oidc_provider_url" {
  description = "OIDC Provider URL"
  value       = aws_iam_openid_connect_provider.eks.url
}

output "eks_oidc_issuer" {
  value = aws_eks_cluster.main.identity[0].oidc[0].issuer
}


output "ebs_csi_driver_role_arn" {
  description = "IAM Role ARN for EBS CSI Driver"
  value       = aws_iam_role.ebs_csi_driver.arn
}
