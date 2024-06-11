locals {
  azs    = data.aws_availability_zones.available.names
  prefix = "${var.project}-${var.environment}"

  # Create a set of peering routes based on the provided peers and the created
  # private route tables.
  peer_cidrs = [
    for key, value in var.peers : {
      key  = key
      cidr = value.cidr
    }
  ]
  peer_routes = [
    for pair in setproduct(local.peer_cidrs, module.vpc.private_route_table_ids) : {
      cidr     = pair[0].cidr
      key      = pair[0].key
      table_id = pair[1]
    }
  ]
}
