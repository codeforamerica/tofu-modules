module "secrets_manager" {
  source  = "terraform-aws-modules/secrets-manager/aws"
  version = "~> 1.1"

  for_each = var.secrets_manager_secrets

  name_prefix             = "${var.project}/${var.environment}/${var.service}/${each.key}-"
  create_random_password  = each.value.create_random_password
  description             = each.value.description
  recovery_window_in_days = each.value.recovery_window
  kms_key_id              = aws_kms_alias.fargate.id

  ignore_secret_changes = true
}
