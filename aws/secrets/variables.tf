variable "environment" {
  type        = string
  description = "Environment for the deployment."
  default     = "dev"
}

variable "key_recovery_period" {
  type        = number
  default     = 30
  description = "Recovery period for deleted KMS keys in days. Must be between 7 and 30."

  validation {
    condition     = var.key_recovery_period > 6 && var.key_recovery_period < 31
    error_message = "Recovery period must be between 7 and 30."
  }
}

variable "project" {
  type        = string
  description = "Project that these resources are supporting."
}

# TODO: Support rotation.
variable "secrets" {
  type = map(object({
    create_random_password = optional(bool, false)
    description            = string
    name                   = optional(string, "")
    recovery_window        = optional(number, 30)
    start_value            = optional(string, "{}")
  }))

  description = "List of VPC peering connections."
  default     = {}
}

variable "service" {
  type        = string
  description = "Optional service that these resources are supporting. Example: 'api', 'web', 'worker'"
  default     = ""
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all resources."
  default     = {}
}
