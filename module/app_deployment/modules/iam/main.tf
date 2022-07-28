# IAM role which dictates what other AWS services the Lambda function may access.
resource "aws_iam_role" "statuspager_lambda_role" {
    name = var.iam_role_name
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

#allowing API gateway and lambda to access each other
resource "aws_lambda_permission" "statuspager_lambda_permission" {
    statement_id    = "AllowAPIGatewayInvoke"
    action          = "lambda:InvokeFunction"
    function_name   = "statuspager-lambda-staging"
    principal       = "apigateway.amazonaws.com"
    source_arn      = "${var.api_arn}/*/*"
}

# Access vpc with AWS lambda
resource "aws_iam_role_policy_attachment" "statuspager_lambda_execution" {
    role = aws_iam_role.statuspager_lambda_role.name
    policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "statuspager_lambda_vpc_access_execution" {
    role = aws_iam_role.statuspager_lambda_role.name
    policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}


