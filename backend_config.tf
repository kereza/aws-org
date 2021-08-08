# Shared file. It is ONLY used when we are doing CLI runs
# NOT used in Terraform Cloud
terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "main-organization"

    workspaces {
      name = "aws-org"
    }
  }
}