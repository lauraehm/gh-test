terraform {
  required_providers {
    aws = {
      source          = "hashicorp/aws"
      version         = "3.27.0"
    }
  }
}

provider "aws" {
    region            = var.region
}

resource "aws_s3_bucket" "gh-test" {
  bucket = "gh-test-2"
}

resource "aws_s3_bucket" "s3" {
  bucket = "${var.project_name}-${var.environment}-s3-terraform-backend"

  lifecycle {
    prevent_destroy = true
  }

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_dynamodb_table" "dynamo" {
  name         = "${var.project_name}-${var.environment}-dynamo-terraform-backend"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}