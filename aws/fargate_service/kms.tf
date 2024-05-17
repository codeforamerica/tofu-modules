resource "aws_kms_key" "fargate" {
  description             = "${var.service} hosting encryption key for ${var.project} ${var.environment}"
  deletion_window_in_days = var.key_recovery_period
  enable_key_rotation     = true
  policy = jsonencode(yamldecode(templatefile("${path.module}/templates/key-policy.yaml.tftpl", {
    account_id : data.aws_caller_identity.identity.account_id,
    partition : data.aws_partition.current.partition,
    region : data.aws_region.current.name,
    repository_name : local.prefix,
  })))
}

resource "aws_kms_alias" "fargate" {
  name          = "alias/${var.project}/${var.environment}/${var.service}"
  target_key_id = aws_kms_key.fargate.id
}
