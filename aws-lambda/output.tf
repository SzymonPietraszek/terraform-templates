output "url" {
  value = aws_lambda_function_url.this.function_url
}

output "access_key" {
  value = aws_iam_access_key.this.id
}

output "secret_key" {
  value     = aws_iam_access_key.this.secret
  sensitive = true
}
