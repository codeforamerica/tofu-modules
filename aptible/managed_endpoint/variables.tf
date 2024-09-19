variable "aptible_environment" {
  type        = string
  description = "Name of the Aptible environment for the endpoint."
}

variable "aptible_resource" {
  type        = string
  description = "ID of the resource to attach the endpoint to."
}

variable "public" {
  type        = bool
  description = "Whether the endpoint should be available to the public Internet."
  default     = false
}

variable "domain" {
  type = string
  description = "Top-level domain name for the endpoint. This will be used to find the Route53 zone."
}
variable "subdomain" {
  type = string
  description = "Subdomain for the endpoint. This will be prepended to the domain."
}
