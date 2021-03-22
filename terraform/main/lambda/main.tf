resource "aws_s3_bucket" "s3_lambda_bucket" {
  bucket = "s3_lambda_bucket"
  acl    = "private"
  
  versioning {
    enabled = true
  }

  tags = {
    Name = "s3_lambda_bucket"
  }
}

resource "aws_s3_bucket_object" "object" {
  bucket = "s3_lambda_bucket"
  key    = "lambda-test.zip"
  source = "lambda-test/lambda-test.zip"
}

resource "aws_lambda_function" "lambda_test" {
   function_name = "lambda_test"

   s3_bucket = "s3_lambda_bucket"
   s3_key    = "lambda-test.zip"

   handler = "lambda_function.lambda_handler"
   runtime = "python3.8"

   role = aws_iam_role.lambda_exec.arn
}

resource "aws_iam_role" "lambda_exec" {
   name = "s3_lambda_bucket_role"

   assume_role_policy = <<EOF
{
  "Version": "2020-03-22",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

}
