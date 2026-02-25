module "argocd" {
  source = "./modules/argocd"
    depends_on = [
        helm_release.alb_controller,
        #CRITICAL — wait for worker nodes
        aws_eks_node_group.microservices
     ]
}
