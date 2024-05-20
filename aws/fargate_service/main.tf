module "ecr" {
  source  = "terraform-aws-modules/ecr/aws"
  version = "~> 2.2"

  repository_name               = local.prefix
  repository_image_scan_on_push = true
  repository_encryption_type    = "KMS"
  repository_kms_key            = aws_kms_key.fargate.arn
  repository_lifecycle_policy = jsonencode(yamldecode(templatefile(
    "${path.module}/templates/repository-lifecycle.yaml.tftpl", {
      untagged_image_retention : var.untagged_image_retention
    }
  )))
}

# If this is a public load balancer, we need to allow all traffic.
#trivy:ignore:avd-aws-0107
module "endpoint_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 5.1"

  name   = "${local.prefix}-endpoint"
  vpc_id = var.vpc_id

  # Ingress for HTTP
  ingress_cidr_blocks = [var.internal ? data.aws_vpc.current.cidr_block : "0.0.0.0/0"]
  ingress_rules       = ["http-80-tcp", "https-443-tcp"]

  # Allow all egress
  egress_cidr_blocks      = [data.aws_vpc.current.cidr_block]
  egress_rules            = ["all-all"]
  egress_ipv6_cidr_blocks = []
}

# TODO: Determine how we can best restrict the egress rules.
#trivy:ignore:avd-aws-0104
module "task_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 5.1"

  name   = "${local.prefix}-endpoint"
  vpc_id = var.vpc_id

  ingress_with_source_security_group_id = [{
    from_port                = var.container_port
    to_port                  = var.container_port
    protocol                 = "tcp"
    description              = "${var.service} access from the load balancer."
    source_security_group_id = module.endpoint_security_group.security_group_id
  }]

  # Allow all egress.
  egress_cidr_blocks      = ["0.0.0.0/0"]
  egress_ipv6_cidr_blocks = ["::/0"]
  egress_rules            = ["all-all"]
}

module "ecs" {
  source  = "HENNGE/ecs/aws"
  version = "~> 4.2"

  name                      = local.prefix
  capacity_providers        = ["FARGATE"]
  enable_container_insights = true
}

module "ecs_service" {
  source     = "HENNGE/ecs/aws//modules/simple/fargate"
  version    = "~> 4.2"
  depends_on = [module.alb, module.ecs]

  name             = local.prefix
  cluster          = module.ecs.arn
  container_port   = var.container_port
  container_name   = local.prefix
  cpu              = 256
  memory           = 512
  desired_count    = 1
  vpc_subnets      = var.private_subnets
  target_group_arn = module.alb.target_groups["endpoint"].arn
  security_groups  = [module.task_security_group.security_group_id]
  iam_daemon_role  = aws_iam_role.execution.arn
  iam_task_role    = aws_iam_role.task.arn

  container_definitions = jsonencode(yamldecode(templatefile(
    "${path.module}/templates/container_definitions.yaml.tftpl", {
      name           = local.prefix
      cpu            = 256
      memory         = 512
      image          = "${module.ecr.repository_url}:${var.image_tag}"
      container_port = var.container_port
      log_group      = aws_cloudwatch_log_group.service.name
      region         = data.aws_region.current.name
    }
  )))
}
