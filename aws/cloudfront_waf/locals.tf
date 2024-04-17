locals {
  subdomain     = var.subdomain == "" ? var.environment : var.subdomain
  origin_domain = var.origin_domain == "" ? "origin.${local.subdomain}.${var.domain}" : var.origin_domain
  prefix        = "${var.project}-${var.environment}"
}
