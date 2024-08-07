output "cluster_endpoint" {
  value = module.database.cluster_endpoint
}

output "secret_arn" {
  value = module.database.cluster_master_user_secret[0].secret_arn
}
