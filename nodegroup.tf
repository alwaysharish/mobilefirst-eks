
# Microservices Node Group

resource "aws_eks_node_group" "microservices" {
  cluster_name    = aws_eks_cluster.main.name
  node_group_name = var.microservices_node_group_name //"eks-microservices"
  node_role_arn   = aws_iam_role.eks_node_group.arn
  subnet_ids      = aws_subnet.private[*].id
  version = aws_eks_cluster.main.version
  instance_types = var.microservices_instance_types //["m6i.large"]
  

  scaling_config {
    desired_size = var.microservices_desired_size
    min_size     = var.microservices_min_size
    max_size     = var.microservices_max_size
  }
  update_config {
    max_unavailable = 1
  }


  labels = {
    nodepool = var.microservices_node_group_name //"eks-microservices"
    workload = "apps"
  }

  launch_template {
    id      = aws_launch_template.eks_nodes.id
    version = aws_launch_template.eks_nodes.latest_version //"$Latest"
  }

  tags = merge(
    local.tags,
    {
      Name = "eks-microservices-node-group"

      # Cluster Autoscaler
      "k8s.io/cluster-autoscaler/${var.cluster_name}" = "owned"
      "k8s.io/cluster-autoscaler/enabled"             = "true"
    }
  )

  lifecycle {
    create_before_destroy = true
  }
}
