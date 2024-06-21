locals {
  azs    = data.aws_availability_zones.available.names
  prefix = "${var.project}-${var.environment}"

  # Define inbound and outbound ACL rules for any peering connections.
  peer_inbound_acls = [
    for peer in var.peers : {
      action      = "allow"
      cidr_block  = peer.cidr
      from_port   = 0
      protocol    = -1
      rule_number = 200
      to_port     = 0
    }
  ]
  peer_outbound_acls = [
    for peer in var.peers : {
      action      = "allow"
      cidr_block  = peer.cidr
      from_port   = 0
      protocol    = -1
      rule_number = 200
      to_port     = 0
    }
  ]

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
