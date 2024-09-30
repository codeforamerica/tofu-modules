resource "aptible_endpoint" "endpoint" {
  env_id       = data.aptible_environment.environment.env_id
  resource_id  = var.aptible_resource
  internal     = !var.public
  domain       = local.fqdn
  managed      = true
  ip_filtering = var.allowed_cidrs

  # TODO: Should these be configurable? Probably.
  resource_type = "app"
  endpoint_type = "https"
  process_type  = "web"
}

resource "aws_route53_record" "endpoint" {
  zone_id = data.aws_route53_zone.domain.zone_id
  name    = aptible_endpoint.endpoint.domain
  type    = "CNAME"
  records = [aptible_endpoint.endpoint.external_hostname]
  ttl     = 300
}

resource "aws_route53_record" "verification" {
  zone_id = data.aws_route53_zone.domain.zone_id
  name    = aptible_endpoint.endpoint.dns_validation_record
  type    = "CNAME"
  records = [aptible_endpoint.endpoint.dns_validation_value]
  ttl     = 300
}
