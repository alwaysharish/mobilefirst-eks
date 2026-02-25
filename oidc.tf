# OIDC Provider for EKS IRSA


# Fetch cluster OIDC issuer certificate dynamically
data "tls_certificate" "eks_oidc" {
  url = aws_eks_cluster.main.identity[0].oidc[0].issuer
}

# Create IAM OIDC Provider
resource "aws_iam_openid_connect_provider" "eks" {
  url = aws_eks_cluster.main.identity[0].oidc[0].issuer

  client_id_list = [
    "sts.amazonaws.com"
  ]

  thumbprint_list = [
    data.tls_certificate.eks_oidc.certificates[0].sha1_fingerprint
  ]

  tags = merge(
    local.tags,
    {
      Name = "${var.cluster_name}-oidc-provider"
    }
  )

  depends_on = [
    aws_eks_cluster.main
  ]
}
