resource "aws_vpc_peering_connection" "peer" {
  for_each = var.peers

  peer_owner_id = each.value.account_id
  peer_vpc_id   = each.value.vpc_id
  vpc_id        = module.vpc.vpc_id
  peer_region   = each.value.region

  tags = {
    Name = "${local.prefix}-${each.key}"
  }
}

# resource "aws_network_acl_rule" "peer_ingress" {
#   for_each = var.peers
#
#   network_acl_id = module.vpc.default_network_acl_id
#   rule_number    = 200
#   egress         = false
#   protocol       = "-1"
#   rule_action    = "allow"
#   cidr_block     = each.value.cidr
# }

# resource "aws_network_acl_rule" "peer_egress" {
#   for_each = var.peers
#
#   network_acl_id = module.vpc.default_network_acl_id
#   rule_number    = 300
#   egress         = true
#   protocol       = "-1"
#   rule_action    = "allow"
#   cidr_block     = each.value.cidr
# }

resource "aws_route" "peer" {
  for_each = tomap({
    for route in local.peer_routes : route.key => route
  })

  route_table_id            = each.value.table_id
  destination_cidr_block    = each.value.cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.peer[each.key].id
}
