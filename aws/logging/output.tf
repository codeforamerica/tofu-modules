output "bucket" {
  value = aws_s3_bucket.logs.bucket
}

output "bucket_domain_name" {
  value = aws_s3_bucket.logs.bucket_domain_name
}

output "kms_key_arn" {
  value = aws_kms_key.logs.arn
}

output "kms_key_alias" {
  value = aws_kms_alias.logs.name
}

output "log_groups" {
  value = { for group in aws_cloudwatch_log_group.logs : group.name => group.arn }
}

output "datadog_lambda" {
  value = length(local.datadog_lambda) > 0 ? local.datadog_lambda[0] : ""
}
