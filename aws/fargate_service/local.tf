locals {
  fqdn         = var.subdomain != "" ? "${var.subdomain}.${var.domain}" : var.domain
  prefix       = "${var.project}-${var.environment}-${var.service}"
  prefix_short = "${var.project_short}-${var.environment}-${var.service_short}"

  authorized_secrets = [
    for key, value in var.environment_secrets :
    startswith(value, "arn:")
    ? join(":", slice(split(":", value), 0, length(split(":", value)) - 1))
    : module.secrets_manager[split(":", value)[0]].secret_arn
  ]
}
