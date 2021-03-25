# resource "aws_s3_bucket" "s3_lambda_bucket" {
#   bucket = "march22laumbucket"
#   acl    = "private"
  
#   versioning {
#     enabled = true
#   }

#   tags = {
#     Name = "s3_lambda_bucket"
#   }
# }

# resource "aws_s3_bucket_object" "object" {
#   bucket = "march22laumbucket"
#   key    = "lambda-test.zip"
#   source = "../../lambda-test/lambda_function.zip"
#   depends_on = [ aws_s3_bucket.s3_lambda_bucket ]
# }

resource "aws_iam_role" "lambda_exec" {
   name = "s3_lambda_bucket_role"

   assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
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

resource "aws_lambda_function" "lambda_test" {
   function_name = var.lambda_name

  #  s3_bucket = "march22laumbucket"
  #  s3_key    = "lambda-test.zip"

   file    = "../../lambda-test/dummy.zip"
   handler = "lambda_function.lambda_handler"
   runtime = "python3.8"

   role = aws_iam_role.lambda_exec.arn
  #  depends_on = [ aws_s3_bucket_object.object ]
}
