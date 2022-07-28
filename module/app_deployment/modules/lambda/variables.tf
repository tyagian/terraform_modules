variable "function_name" {
    description = "Name of lambda name"
    type        = string
    default     = "statuspager-lambda-staging"
}

variable "lambda_arn" {
    description = "lambda_arn"
    type        = string  
}

variable "iam_role_arn" {
    description = "lambda role arn"
    type        = string
}