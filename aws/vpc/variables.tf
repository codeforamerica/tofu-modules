variable "cidr" {
  type        = string
  description = "IPv4 CIDR block for the VPC."
}

variable "environment" {
  type        = string
  description = "Environment for the deployment."
  default     = "dev"
}

variable "log_retention_period" {
  type        = number
  default     = 30
  description = "Retention period for flow logs, in days."
}

variable "logging_key_id" {
  type        = string
  description = "KMS key ID for encrypting logs."
}

variable "peers" {
  type = map(object({
    account_id = string
    cidr       = string
    region     = string
    vpc_id     = string
  }))

  description = "List of VPC peering connections."
}

variable "private_subnets" {
  type        = list(string)
  description = "List of private subnet CIDR blocks."
}

variable "project" {
  type        = string
  description = "Project that these resources are supporting."
}

variable "public_subnets" {
  type        = list(string)
  description = "List of public subnet CIDR blocks."
}

variable "single_nat_gateway" {
  type        = bool
  default     = false
  description = "Enable to deploy one NAT gateway rather than one per subnet. Cheaper, but is not highly available."
}
