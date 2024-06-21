output "availability_zones" {
  value = module.vpc.azs
}

output "peer_ids" {
  value = [for peer in aws_vpc_peering_connection.peer : peer.id]
}

output "private_subnets" {
  value = module.vpc.private_subnets
}

output "public_subnets" {
  value = module.vpc.public_subnets
}

output "vpc_id" {
  value = module.vpc.vpc_id
}
