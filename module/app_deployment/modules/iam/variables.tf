variable "iam_role_name" {
    description = "Name of the api gateway name"
    type = string
    default = "statuspager_lambda_role"
}

variable "api_arn" {
    description = "Name of the api gateway name"
    type = string
    //default = "statuspager_lambda_role"
}

variable "iam_role_arn" {
  description = "Name of the api gateway name"
  type = string
  //default = "statuspager_lambda_role"
}

variable "lambda_arn" {
    description = "lambda_arn"
    type = string
}