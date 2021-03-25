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

data "template_file" "template_lambda"{
  template = "test-bash.sh"

  vars     = {
    lambda_name = var.lambda_name
  }
}

resource "local_file" "gh_lambda" {
  content    = data.template_file.template_lambda.rendered
  filename   = "../.github/workflows/"
}

module "lambda" {
  source = "./lambda"
  lambda_name = var.lambda_name
}
