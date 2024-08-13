resource "aws_cloudwatch_log_group" "service" {
  name              = "/aws/ecs/${var.project}/${var.environment}/${var.service}"
  retention_in_days = 30
  kms_key_id        = var.logging_key_id

  tags = var.tags
}
