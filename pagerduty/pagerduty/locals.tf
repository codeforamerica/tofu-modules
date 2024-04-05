locals {
  memberships = flatten([
    for key, team in var.teams : [
      for username in keys(team.members) : {
        user = username
        team = key
        role = team.members[username] == null ? "responder" : team.members[username].pagerduty_role
      }
    ] if team.members != null
  ])
}
