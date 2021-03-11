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

resource "aws_s3_bucket" "s3-test" {
  bucket = "s3-terraform-backend-gh-test"

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

resource "aws_dynamodb_table" "dynamo-test" {
  name         = "dynamo-terraform-backend-gh-test"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
