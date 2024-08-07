variable "apply_immediately" {
  type        = bool
  description = "Whether to apply changes immediately rather than during the next maintenance window."
  default     = false
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

variable "logging_key_arn" {
  type        = string
  description = "ARN of the KMS key for logging."
}

variable "ingress_cidrs" {
  type        = list(string)
  description = "List of CIDR blocks to allow ingress. This is typically your private subnets."
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

variable "min_capacity" {
  type        = number
  description = "Minimum capacity for the serverless cluster in ACUs."
  default     = 2
}

variable "max_capacity" {
  type        = number
  description = "Maximum capacity for the serverless cluster in ACUs."
  default     = 10
}

variable "project" {
  type        = string
  description = "Project that these resources are supporting."
}

variable "secrets_key_arn" {
  type        = string
  description = "ARN of the KMS key for secrets. This will be used to encrypt database credentials."
}

variable "service" {
  type        = string
  description = "Optional service that these resources are supporting. Example: 'api', 'web', 'worker'"
  default     = ""
}

variable "skip_final_snapshot" {
  type        = bool
  description = "Whether to skip the final snapshot when destroying the database cluster."
  default     = false
}

variable "snapshot_identifier" {
  type        = string
  description = "Optional name or ARN of the snapshot to restore the cluster from. Only applicable on create."
  default     = ""
}

variable "subnets" {
  type        = list(string)
  description = "List of subnet ids the database instances may be placed in"
}

variable "vpc_id" {
  type        = string
  description = "Id of the VPC to launch the database cluster into."
}
