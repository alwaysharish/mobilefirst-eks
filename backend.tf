terraform {
  backend "s3" {
    bucket = "bon-infra-aws-terraform"
    region = "us-west-1"
    key    = "bon-infra/terraform.tfstate"
  }
}