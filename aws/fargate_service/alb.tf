module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 9.9"

  for_each = var.create_endpoint ? toset(["this"]) : toset([])

  name                       = local.prefix_short
  enable_deletion_protection = !var.force_delete
  load_balancer_type         = "application"
  security_groups            = [module.endpoint_security_group.security_group_id]
  subnets                    = var.public ? var.public_subnets : var.private_subnets
  vpc_id                     = var.vpc_id
  internal                   = !var.public

  # TODO: Support IPv6 and/or dualstack.
  ip_address_type = "ipv4"

  listeners = {
    http = {
      port     = 80
      protocol = "HTTP"
      redirect = {
        port        = "443"
        protocol    = "HTTPS"
        status_code = "HTTP_301"
      }
    }

    https = {
      port            = 443
      protocol        = "HTTPS"
      ssl_policy      = "ELBSecurityPolicy-TLS-1-2-2017-01"
      certificate_arn = aws_acm_certificate.endpoint["this"].arn
      forward = {
        target_group_key = "endpoint"
      }
    }
  }

  target_groups = {
    endpoint = {
      name        = "${local.prefix_short}-app"
      protocol    = "HTTP"
      target_type = "ip"
      port        = var.container_port

      # Theres nothing to attach here in this definition. Instead, ECS will
      # attach the IPs of the tasks to this target group.
      create_attachment = false

      health_check = {
        path                = "/health"
        healthy_threshold   = 5
        unhealthy_threshold = 2
      }
    }
  }

  tags = var.tags
}

resource "aws_acm_certificate" "endpoint" {
  for_each = var.create_endpoint ? toset(["this"]) : toset([])

  domain_name       = local.fqdn
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }

  tags = var.tags
}

resource "aws_route53_record" "endpoint" {
  for_each = var.create_endpoint ? toset(["this"]) : toset([])

  name    = local.fqdn
  type    = "A"
  zone_id = data.aws_route53_zone.domain["this"].zone_id

  alias {
    name                   = module.alb["this"].dns_name
    zone_id                = module.alb["this"].zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "endpoint_validation" {
  for_each = var.create_endpoint ? {
    for dvo in aws_acm_certificate.endpoint["this"].domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  } : {}

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.domain["this"].zone_id
}

resource "aws_acm_certificate_validation" "endpoint" {
  for_each = var.create_endpoint ? toset(["this"]) : toset([])

  certificate_arn = aws_acm_certificate.endpoint["this"].arn
  validation_record_fqdns = [
    for record in aws_route53_record.endpoint_validation : record.fqdn
  ]
}
