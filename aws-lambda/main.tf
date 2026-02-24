data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "role" {
  name               = "role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy_attachment" "logs" {
  role       = aws_iam_role.role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "archive_file" "zip" {
  type        = "zip"
  source_file = "${path.module}/lambda.py"
  output_path = "${path.module}/lambda.zip"

  provisioner "local-exec" {
    command = "rm -f ${self.output_path}"
    when    = destroy
  }
}


resource "aws_lambda_function" "lambda" {
  function_name = "lambda"
  role          = aws_iam_role.role.arn
  filename      = archive_file.zip.output_path
  code_sha256   = archive_file.zip.output_base64sha256
  handler       = "lambda.handler"
  runtime       = "python3.14"

  # reserved_concurrent_executions = 1
  # Limit to 1 concurrent execution to limit costs
  # if you get an error:
  # "Specified ReservedConcurrentExecutions for function decreases account's UnreservedConcurrentExecution below its minimum value of [10].""
  # it probably means you have a test account with 10 concurrent executions limit, but you can reserve up to the Unreserved account concurrency value minus 100
  # https://eu-central-1.console.aws.amazon.com/servicequotas/home/services/lambda/quotas
}


resource "aws_lambda_function_url" "url" {
  function_name      = aws_lambda_function.lambda.function_name
  authorization_type = "AWS_IAM"
}

resource "aws_lambda_permission" "function_url_public" {
  statement_id           = "AllowPublicInvokeFunctionUrl"
  action                 = "lambda:InvokeFunctionUrl"
  function_name          = aws_lambda_function.lambda.function_name
  principal              = "*"
  function_url_auth_type = aws_lambda_function_url.url.authorization_type
}

resource "aws_iam_user" "lambda_invoker" {
  name = "lambda-url-invoker"
}

resource "aws_iam_access_key" "lambda_invoker" {
  user = aws_iam_user.lambda_invoker.name
}

resource "aws_iam_policy" "invoke_lambda_url" {
  name = "invoke-lambda-url"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "lambda:InvokeFunctionUrl",
          "lambda:InvokeFunction",
        ]
        Resource = aws_lambda_function.lambda.arn
      }
    ]
  })
}

resource "aws_iam_user_policy_attachment" "attach" {
  user       = aws_iam_user.lambda_invoker.name
  policy_arn = aws_iam_policy.invoke_lambda_url.arn
}

output "url" {
  value = aws_lambda_function_url.url.function_url
}

output "access_key" {
  value = aws_iam_access_key.lambda_invoker.id
}

output "secret_key" {
  value     = aws_iam_access_key.lambda_invoker.secret
  sensitive = true
}
