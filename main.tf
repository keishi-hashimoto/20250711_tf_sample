terraform {
  required_version = ">=1.2"

  required_providers {
    aws = {
      version = "~> 4.16"
      source  = "hashicorp/aws"
    }
  }

  backend "s3" {
    bucket = ""
    key    = ""
  }
}

module "main" {
  source = "./modules"
}

