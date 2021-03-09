terraform {
  required_version = "~> 0.14.0"

  backend "s3" {
    bucket         = "fraud-detector-poc-development-s3-terraform-backend"
    key            = "fraud-detector-poc-development.tfstate"
    region         = "us-east-1"
    dynamodb_table = "fraud-detector-poc-development-dynamo-terraform-backend"
    encrypt        = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.27.0"
    }
    template = {
      source  = "hashicorp/template"
      version = "2.2.0"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = var.region
}
