output "iam_role_arn" {
    value = "${aws_iam_role.statuspager_lambda_role.arn}"
}