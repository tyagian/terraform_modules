output "api_arn" {
    value = "${aws_api_gateway_deployment.statuspager_api_deployment.execution_arn}"
}