data "aws_caller_identity" "identity" {}

data "aws_partition" "current" {}

data "aws_region" "current" {}

data "aws_route53_zone" "domain" {
  name = var.domain
}

data "aws_vpc" "current" {
  id = var.vpc_id
}
