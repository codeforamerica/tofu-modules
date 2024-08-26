locals {
  fqdn           = var.subdomain != "" ? "${var.subdomain}.${var.domain}" : var.domain
  image_url      = var.create_repository ? module.ecr["this"].repository_url : var.image_url
  prefix         = "${var.project}-${var.environment}-${var.service}"
  prefix_short   = "${var.project_short}-${var.environment}-${var.service_short}"
  repository_arn = var.create_repository ? module.ecr["this"].repository_arn : var.repository_arn

  authorized_secrets = [
    for key, value in var.environment_secrets :
    startswith(value, "arn:")
    ? join(":", slice(split(":", value), 0, length(split(":", value)) - 1))
    : module.secrets_manager[split(":", value)[0]].secret_arn
  ]
}
