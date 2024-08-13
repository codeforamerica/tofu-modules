module "database" {
  source  = "terraform-aws-modules/rds-aurora/aws"
  version = "~> 9.8"

  name                   = local.prefix
  create_db_subnet_group = true
  db_subnet_group_name   = local.prefix
  engine                 = "aurora-postgresql"
  engine_mode            = "provisioned"
  storage_encrypted      = true
  kms_key_id             = aws_kms_key.database.arn
  master_username        = "root"
  subnets                = var.subnets
  copy_tags_to_snapshot  = true
  snapshot_identifier    = var.snapshot_identifier
  deletion_protection    = !var.force_delete

  vpc_id = var.vpc_id
  security_group_rules = {
    ingress = {
      cidr_blocks = var.ingress_cidrs
    }
  }

  manage_master_user_password                            = true
  manage_master_user_password_rotation                   = true
  master_user_password_rotation_automatically_after_days = 30

  cloudwatch_log_group_kms_key_id        = var.logging_key_arn
  cloudwatch_log_group_retention_in_days = 7
  performance_insights_kms_key_id        = var.logging_key_arn
  performance_insights_enabled           = true
  performance_insights_retention_period  = 7

  # TODO: Create a database KMS key
  master_user_secret_kms_key_id = var.secrets_key_arn

  monitoring_interval = 60

  apply_immediately   = var.apply_immediately
  skip_final_snapshot = var.skip_final_snapshot

  serverlessv2_scaling_configuration = {
    min_capacity = var.min_capacity
    max_capacity = var.max_capacity
  }

  instance_class = "db.serverless"
  # TODO: Make the number of instances configurable.
  instances = {
    one = {}
    two = {}
  }

  tags = var.tags
}
