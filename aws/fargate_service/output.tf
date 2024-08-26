output "cluster_name" {
  value = module.ecs.name
}

output "docker_push" {
  value = !var.create_repository ? "" : <<EOT
aws ecr get-login-password --region ${data.aws_region.current.name} | docker login --username AWS --password-stdin ${module.ecr["this"].repository_registry_id}.dkr.ecr.${data.aws_region.current.name}.amazonaws.com
docker build -t ${module.ecr["this"].repository_name} --platform linux/amd64 .
docker tag ${module.ecr["this"].repository_name}:${var.image_tag} ${module.ecr["this"].repository_url}:latest
docker push ${module.ecr["this"].repository_url}:latest
EOT
}

output "repository_arn" {
  value = local.repository_arn
}

output "repository_url" {
  value = local.image_url
}
