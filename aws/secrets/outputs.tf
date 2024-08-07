output "kms_key_alias" {
  value = aws_kms_alias.secrets.name
}

output "kms_key_arn" {
  value = aws_kms_key.secrets.arn
}

output "secrets" {
  value = module.secrets_manager
}
