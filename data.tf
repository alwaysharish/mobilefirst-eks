data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_partition" "current" {}


data "aws_eks_cluster" "cluster" {
  name = aws_eks_cluster.main.name
  depends_on = [aws_eks_cluster.main,
    aws_eks_node_group.microservices
   ]
}

data "aws_eks_cluster_auth" "cluster" {
  name = aws_eks_cluster.main.name
  depends_on = [aws_eks_cluster.main]
}



#cluster addons data sources
data "aws_eks_addon_version" "vpc_cni" {
  addon_name         = "vpc-cni"
  kubernetes_version = var.cluster_version
  most_recent        = true
}

data "aws_eks_addon_version" "coredns" {
  addon_name         = "coredns"
  kubernetes_version = var.cluster_version
  most_recent        = true
}

data "aws_eks_addon_version" "kube_proxy" {
  addon_name         = "kube-proxy"
  kubernetes_version = var.cluster_version
  most_recent        = true
}

data "aws_eks_addon_version" "ebs_csi" {
  addon_name         = "aws-ebs-csi-driver"
  kubernetes_version = var.cluster_version
  most_recent        = true
}
#

