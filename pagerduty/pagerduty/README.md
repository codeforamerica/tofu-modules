# PagerDuty module
 
This module manages [PagerDuty] users, teams, and memberships.

## Usage

```ruby
# TODO: Implement.
```

## Inputs

| Name   | Description                             | Type     | Default              | Required |
|--------|-----------------------------------------|----------|----------------------|:--------:|
| token  | The PagerDuty API token.                | `string` | n/a                  |   yes    |
| users  | A list of users to create.              | `map`    | n/a                  |   yes    |
| teams  | A list of teams to create.              | `map`    | n/a                  |   yes    |
| domain | Domain to use for user email addresses. | `map`    | `codeforamerica.org` |    no    |

### Users

Users should be provided as a map of objects with the following properties. Each
user's key should be their email address prefix (The domain will be appended
automatically).

| Name           | Description                    | Type     | Default | Required |
|----------------|--------------------------------|----------|---------|:--------:|
| name           | Display name of the user.      | `string` | n/a     |   yes    |
| pagerduty_role | The role the user should have. | `string` | `user`  |    no    |

### Teams

Users should be provided as a map of objects with the following properties:

| Name        | Description                        | Type     | Default | Required |
|-------------|------------------------------------|----------|---------|:--------:|
| name        | Display name of the team.          | `string` | n/a     |   yes    |
| description | A description for the team.        | `string` | n/a     |   yes    |
| members     | A map of users to add to the team. | `map`    | `{}`    |    no    |

They key for each member should be their email address prefix (matching the
`users` variable above) and may include the optional values below.

| Name           | Description                                     | Type     | Default     |
|----------------|-------------------------------------------------|----------|-------------|
| pagerduty_role | Role that the user should hold within the team. | `string` | `responder` |

[pagerduty]: https://www.pagerduty.com/
