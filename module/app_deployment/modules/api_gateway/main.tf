resource "aws_api_gateway_rest_api" "statuspager_api" {
    name = var.api_name
}

// added for path
resource "aws_api_gateway_resource" "statuspager_resource" {
  parent_id   = aws_api_gateway_rest_api.statuspager_api.root_resource_id
  rest_api_id = aws_api_gateway_rest_api.statuspager_api.id
  path_part   = "{${var.resource_name}}"
}

resource "aws_api_gateway_method" "post_form" {
    rest_api_id = aws_api_gateway_rest_api.statuspager_api.id
    resource_id = aws_api_gateway_resource.statuspager_resource.id #aws_api_gateway_rest_api.statuspager_api.root_resource_id
    http_method = "POST"
    authorization = "None"
}

resource "aws_api_gateway_integration" "statuspager_api_integrationrootpost" {
  rest_api_id = aws_api_gateway_rest_api.statuspager_api.id
  resource_id = aws_api_gateway_resource.statuspager_resource.id
  http_method = aws_api_gateway_method.post_form.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "${var.lambda_arn}"
}

// added response
resource "aws_api_gateway_method_response" "response_200" {
  rest_api_id = aws_api_gateway_rest_api.statuspager_api.id
  resource_id = aws_api_gateway_resource.statuspager_resource.id
  http_method = aws_api_gateway_method.post_form.http_method
  status_code = "200"

  response_models = { "application/json" = "Empty" }
}

// integration response
resource "aws_api_gateway_integration_response" "IntegrationResponse" {
  depends_on = [aws_api_gateway_integration.statuspager_api_integrationrootpost]
  rest_api_id = aws_api_gateway_rest_api.statuspager_api.id
  resource_id = aws_api_gateway_resource.statuspager_resource.id
  http_method = aws_api_gateway_method.post_form.http_method
  status_code = aws_api_gateway_method_response.response_200.status_code
  # Transforms the backend JSON response to json. The space is "A must have"
  response_templates = {
    "application/json" = <<EOF
 
 EOF
  }
}

resource "aws_api_gateway_deployment" "statuspager_api_deployment" {
    depends_on = [
        aws_api_gateway_integration.statuspager_api_integrationrootpost,
        aws_api_gateway_integration_response.IntegrationResponse,
        ]
    rest_api_id = aws_api_gateway_rest_api.statuspager_api.id
    stage_name = var.stage
}