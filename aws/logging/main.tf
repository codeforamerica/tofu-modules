# We don't want to log access to this bucket, as that would cause an infinite
# loop of logging.
#trivy:ignore:avd-aws-0089
resource "aws_s3_bucket" "logs" {
  bucket = "${local.prefix}-logs"

  lifecycle {
    prevent_destroy = true
  }

  tags = var.tags
}

resource "aws_s3_bucket_public_access_block" "good_example" {
  bucket                  = aws_s3_bucket.logs.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

#tfsec:ignore:aws-s3-encryption-customer-key
resource "aws_s3_bucket_server_side_encryption_configuration" "logs" {
  bucket = aws_s3_bucket.logs.id

  rule {
    bucket_key_enabled = true

    apply_server_side_encryption_by_default {
      # S3 access logs don't support encryption with a customer managed key
      # (CMK).
      # See https://repost.aws/knowledge-center/s3-server-access-log-not-delivered
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_versioning" "logs" {
  bucket = aws_s3_bucket.logs.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_policy" "logs" {
  bucket = aws_s3_bucket.logs.id
  policy = jsonencode(yamldecode(templatefile("${path.module}/templates/bucket-policy.yaml.tftpl", {
    account_id : data.aws_caller_identity.identity.account_id,
    partition : data.aws_partition.current.partition,
    bucket_arn : aws_s3_bucket.logs.arn,
    elb_account_arn : data.aws_elb_service_account.current.arn
  })))
}

resource "aws_kms_key" "logs" {
  description             = "Logging encryption key for ${var.project} ${var.environment}"
  deletion_window_in_days = var.key_recovery_period
  enable_key_rotation     = true
  policy = jsonencode(yamldecode(templatefile("${path.module}/templates/key-policy.yaml.tftpl", {
    account_id : data.aws_caller_identity.identity.account_id
    partition : data.aws_partition.current.partition
    region : data.aws_region.current.name
    bucket_arn : aws_s3_bucket.logs.arn
    project : var.project
    environment : var.environment
  })))

  tags = var.tags
}

resource "aws_kms_alias" "logs" {
  name          = "alias/${var.project}/${var.environment}/logs"
  target_key_id = aws_kms_key.logs.id
}
