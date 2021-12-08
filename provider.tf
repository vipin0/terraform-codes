terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "3.68.0"
    }
  }
}

provider "aws" {
  # Configuration options
  profile = var.credential_profile
  region  = var.region
}