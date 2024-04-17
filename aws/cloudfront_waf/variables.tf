variable "domain" {
  type        = string
  description = "Domain used for this deployment."
}

variable "environment" {
  type        = string
  description = "Environment for the deployment."
  default     = "dev"
}

variable "log_bucket" {
  type        = string
  description = "S3 Bucket to send logs to."
}

variable "origin_domain" {
  type        = string
  description = "Origin domain this deployment will point to. Defaults to origin.subdomain.domain."
  default     = ""
}

variable "project" {
  type        = string
  description = "Project that these resources are supporting."
}

variable "subdomain" {
  type        = string
  description = "Subdomain used for this deployment. Defaults to the environment."
  default     = ""
}
