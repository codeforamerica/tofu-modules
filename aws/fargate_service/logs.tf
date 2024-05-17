resource "aws_cloudwatch_log_group" "service" {
  name = "/aws/ecs/${var.project}/${var.environment}/${var.service}"
  retention_in_days = 30
}
