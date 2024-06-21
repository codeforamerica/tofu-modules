locals {
  fqdn         = var.subdomain != "" ? "${var.subdomain}.${var.domain}" : var.domain
  prefix       = "${var.project}-${var.environment}-${var.service}"
  prefix_short = "${var.project_short}-${var.environment}-${var.service_short}"
}
