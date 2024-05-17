output "bucket" {
  value = aws_s3_bucket.logs.bucket
}

output "kms_key_arn" {
  value = aws_kms_key.logs.arn
}

output "kms_key_alias" {
  value = aws_kms_alias.logs.name
}
