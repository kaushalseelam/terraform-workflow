variable "allowed_account_id" {
  description = "The id  of the one AWS account this code is permitted to run against"
  type        = string
}


provider "aws" {
  region              = "us-west-1"
  allowed_account_ids = [var.allowed_account_id]
}

terraform {
  backend "s3" {
    bucket = "andrei-terraform-state-3"
    key    = "default-infrastructure-3"
    region = "us-west-1"
  }
}
