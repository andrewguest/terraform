terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 3.27"
    }
  }
}

provider "aws" {
  profile = "default"
  region = "us-east-1"
}

data "aws_iam_policy_document" "lambda_assum_role_policy" {
  statement {
    effect = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "lambda_role" {
  name = "lambda-lamdaRole-waf"
  assume_role_policy = data.aws_iam_policy_document.lambda_assum_role_policy
}

data "archive_file" "python_lambda_package" {
    type = "zip"
    source_file = "${path.module}/code/lambda_function.py"
    output_path = "nametest.zip"
}

resource "aws_lambda_function" "test_lambda_function" {
  function_name = "lambdaTest"
  filename = "nametest.zip"
  source_code_hash = data.archive_file.python_lambda_package.output_base64sha256
  role = aws_iam_role.lambda_role.arn
  runtime = "python3.9"
  handler = "lambda_function.lambda_handler"
  timeout = 10
}
