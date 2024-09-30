data "aptible_environment" "environment" {
  handle = var.aptible_environment
}

data "aws_route53_zone" "domain" {
  name = var.domain
}
