variable "domain" {
    description = "The domain to use for user email addresses."
    type        = string
    default = "codeforamerica.org"
}

variable "teams" {
  description = "A dictionary of teams to be created."
  type = map(object({
    name        = string
    description = string
    members     = optional(map(object({
      pagerduty_role = optional(string, "responder")
    })), {})
  }))
}

variable "token" {
  description = "The API token to access PagerDuty."
  type        = string
}

variable "users" {
  description = "A dictionary of users to be created."
  type = map(object({
    name           = string
    pagerduty_role = optional(string, "user")
  }))
}
