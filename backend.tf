terraform {
  backend "s3" {
    bucket = "terraform-state-mobilefirst-eks"
    region = "us-east-1"
    key    = "mobilefirst-eks/terraform.tfstate"
  }
}
