resource "pagerduty_team" "teams" {
  for_each = var.teams

  name        = each.value.name
  description = each.value.description
}

resource "pagerduty_user" "users" {
  for_each = var.users

  name  = each.value.name
  email = "${each.key}@${var.domain}"
  role  = each.value.pagerduty_role
}

resource "pagerduty_team_membership" "memberships" {
  for_each = {
    for membership in local.memberships :
    "${membership.user}-${membership.team}" => membership
  }

  team_id = pagerduty_team.teams[each.value.team].id
  user_id = pagerduty_user.users[each.value.user].id
  role = each.value.role
}
