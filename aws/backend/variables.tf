variable "environment" {
  type        = string
  default     = "dev"
  description = "Environment for the deployment."
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

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all resources."
  default     = {}
}
