# ArgoCD Namespace
resource "kubernetes_namespace_v1" "argocd" {
  metadata {
    name = "argocd"
  }
}

# ArgoCD Helm Installation
resource "helm_release" "argocd" {
  depends_on = [
    kubernetes_namespace_v1.argocd
  ]

  name      = "argocd"
  namespace = kubernetes_namespace_v1.argocd.metadata[0].name

  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "5.51.6" # stable version

  timeout         = 600
  wait            = true
  atomic          = true
  cleanup_on_fail = true

  values = [
    file("${path.module}/values.yaml")
  ]
}

# Output ArgoCD information
output "argocd_server_url" {
  description = "ArgoCD Server URL"
  value       = "https://argocd-dev.boncredit.ai"
}

output "argocd_admin_password_command" {
  description = "Command to get ArgoCD admin password"
  value       = "kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d"
}
