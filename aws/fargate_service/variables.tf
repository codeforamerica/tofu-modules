variable "container_port" {
  type        = number
  description = "Port that the container listens on."
  default     = 80
}

variable "domain" {
  type        = string
  description = "Domain name for the service."
}

variable "environment" {
  type        = string
  description = "Environment for the deployment."
  default     = "dev"
}

variable "force_delete" {
  type        = bool
  description = "Force deletion of resources. If changing to true, be sure to apply before destroying."
  default     = false
}

# TODO: Support external images?
variable "image_tag" {
  type        = string
  description = "Tag for the image to be deployed."
  default     = "latest"
}

variable "internal" {
  type        = bool
  description = "This is an internal service that should not be exposed to the public Internet."
  default     = false
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

variable "logging_key_id" {
  type        = string
  description = "KMS key ID for encrypting logs."
}

variable "private_subnets" {
  type        = list(string)
  description = "List of private subnets."
}

variable "project" {
  type        = string
  description = "Project that these resources are supporting."
}

variable "project_short" {
  type        = string
  description = "Short name for the project. Used in resource names with character limits."
}

variable "public_subnets" {
  type        = list(string)
  description = "List of public subnets."
}

variable "service" {
  type        = string
  description = "Service that these resources are supporting. Example: 'api', 'web', 'worker'"
}

variable "service_short" {
  type        = string
  description = "Short name for the service. Used in resource names with character limits."
}

variable "untagged_image_retention" {
  type        = number
  default     = 14
  description = "Retention period (after push) for untagged images, in days."
}

variable "vpc_id" {
  type        = string
  description = "Id of the VPC to deploy into."
}
