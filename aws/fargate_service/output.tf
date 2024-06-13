output "cluster_name" {
  value = module.ecs.name
}

output "docker_push" {
  value = <<EOT
aws ecr get-login-password --region ${data.aws_region.current.name} | docker login --username AWS --password-stdin ${module.ecr.repository_registry_id}.dkr.ecr.${data.aws_region.current.name}.amazonaws.com
docker build -t ${module.ecr.repository_name} --platform linux/amd64 .
docker tag ${module.ecr.repository_name}:${var.image_tag} ${module.ecr.repository_url}:latest
docker push ${module.ecr.repository_url}:latest
EOT
}
