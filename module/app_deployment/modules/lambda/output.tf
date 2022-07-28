output "lambda_arn" {
    value   = aws_lambda_function.statuspager_lambda.invoke_arn 
}