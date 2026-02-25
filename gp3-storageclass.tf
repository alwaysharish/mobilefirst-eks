resource "kubernetes_storage_class_v1" "gp3" {

  metadata {
    name = "gp3"

    annotations = {
      "storageclass.kubernetes.io/is-default-class" = "true"
    }
  }

  storage_provisioner = "ebs.csi.aws.com"
  reclaim_policy      = "Retain"

  parameters = {
    type       = "gp3"
    fsType     = "ext4"
    iops       = "3000"
    throughput = "125"
  }

  volume_binding_mode = "WaitForFirstConsumer"

  allow_volume_expansion = true
  depends_on = [
    aws_eks_cluster.main,
    aws_eks_node_group.microservices,
    aws_eks_addon.ebs_csi_driver
  ]
}
