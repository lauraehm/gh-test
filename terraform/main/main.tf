terraform {
  required_version = "~> 0.14.0"

  backend "s3" {
    bucket         = "s3-terraform-backend-gh-test"
    key            = "fraud-detector-poc-development.tfstate"
    region         = "us-east-1"
    dynamodb_table = "dynamo-terraform-backend-gh-test"
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

##VPC TEST
resource "aws_vpc" "terraform-vpc" {
  cidr_block           = "11.0.0.0/16"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"
  instance_tenancy     = "default"

  tags = {
    "Name" = "var.project"
    "test" = "testing"
  }
}
