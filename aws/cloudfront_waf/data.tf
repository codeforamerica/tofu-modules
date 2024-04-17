data "aws_cloudfront_origin_request_policy" "managed_cors" {
  name = "Managed-CORS-CustomOrigin"
}

data "aws_cloudfront_response_headers_policy" "managed_cors" {
  name = "Managed-SimpleCORS"
}

data "aws_route53_zone" "domain" {
  name = var.domain
}
