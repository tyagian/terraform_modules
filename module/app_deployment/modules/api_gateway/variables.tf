variable "api_name" {
    description = "Name of the api gateway name"
    type        = string
    default     = "statuspager_api_dev"
}

variable "stage" {
  default = "dev"
}

variable "lambda_arn" {
  description = "lambda_arn"
  type         = string
}

variable "resource_name" {
  default = "efhh2382hed2323"
}