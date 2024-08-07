output "availability_zones" {
  value = module.vpc.azs
}

output "peer_ids" {
  value = [for peer in aws_vpc_peering_connection.peer : peer.id]
}

output "private_subnets" {
  value = module.vpc.private_subnets
}

output "private_subnets_cidr_blocks" {
  value = module.vpc.private_subnets_cidr_blocks
}

output "public_subnets" {
  value = module.vpc.public_subnets
}

output "public_subnets_cidr_blocks" {
  value = module.vpc.public_subnets_cidr_blocks
}

output "vpc_id" {
  value = module.vpc.vpc_id
}
