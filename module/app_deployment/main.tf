provider "aws" {
  region = "us-east-2"
}


module "iam" {
  source       = "./modules/iam"
  api_arn      = module.api_gateway.api_arn
  iam_role_arn = module.iam.iam_role_arn
  lambda_arn   = module.lambda.lambda_arn
}

module "lambda" {
  source       = "./modules/lambda"
  lambda_arn   = module.lambda.lambda_arn
  iam_role_arn = module.iam.iam_role_arn
}


module "api_gateway" {
  source     = "./modules/api_gateway"
  lambda_arn = module.lambda.lambda_arn
}
