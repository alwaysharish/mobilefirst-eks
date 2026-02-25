locals {
  owners        = var.owners
  environment   = var.environment
  maintained_by = "alwaysharish071@gmail.com"

  tags = {
    maintainer  = local.maintained_by
    owners      = local.owners
    environment = local.environment
    project     = var.project_name
    managedBy   = "Terraform"
  }
}
