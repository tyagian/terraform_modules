resource "aws_lambda_function" "statuspager_lambda" {
    function_name       = var.function_name
    filename            = "${path.module}/hello_lambda.zip"
    handler             = "hello_lambda.lambda_handler"
    runtime             = "python3.8"
    role                = "${var.iam_role_arn}"
    source_code_hash    = data.archive_file.hello_lambda.output_base64sha256

    vpc_config {
        subnet_ids          = ["subnet-0a3ca7e57d354999b"]
        security_group_ids  = ["sg-021e1956d59cecaa1"]
    }
}

data "archive_file" "hello_lambda" {
    type = "zip"
    source_dir = "${path.module}/hello_lambda"
    output_path = "${path.module}/hello_lambda.zip"
}

