module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "~> 5.8"
  # TODO: Support more dynamic az count.
  azs    = slice(local.azs, 0, 3)

  name = local.prefix
  cidr = var.cidr

  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  enable_nat_gateway   = true
  single_nat_gateway   = var.single_nat_gateway
  enable_dns_hostnames = true
  enable_dns_support   = true

  create_flow_log_cloudwatch_iam_role             = true
  create_flow_log_cloudwatch_log_group            = true
  enable_flow_log                                 = true
  flow_log_cloudwatch_log_group_kms_key_id        = var.logging_key_id
  flow_log_cloudwatch_log_group_retention_in_days = var.log_retention_period

  private_outbound_acl_rules = [
    {
      # Allow all inner-vpc outbound traffic.
      action      = "allow"
      cidr_block  = var.cidr
      from_port   = 0
      protocol    = -1
      rule_number = 100
      to_port     = 0
    },
    {
      # Allow outbound traffic on port 443.
      action      = "allow"
      cidr_block  = "0.0.0.0/0"
      from_port   = 443
      protocol    = 6
      rule_number = 110
      to_port     = 443
    }
  ]

  private_inbound_acl_rules = [
    {
      # Allow all inner-vpc inbound traffic.
      action      = "allow"
      cidr_block  = var.cidr
      from_port   = 0
      protocol    = -1
      rule_number = 100
      to_port     = 0
    }
  ]

  public_outbound_acl_rules = [
    {
      # Allow all inner-vpc outbound traffic.
      action      = "allow"
      cidr_block  = var.cidr
      from_port   = 0
      protocol    = -1
      rule_number = 100
      to_port     = 0
    },
    {
      # Allow outbound traffic on port 443.
      action      = "allow"
      cidr_block  = "0.0.0.0/0"
      from_port   = 443
      protocol    = 6
      rule_number = 110
      to_port     = 443
    },
    {
      # Allow outbound traffic on port 80.
      action      = "allow"
      cidr_block  = "0.0.0.0/0"
      from_port   = 80
      protocol    = 6
      rule_number = 110
      to_port     = 80
    }
  ]

  public_inbound_acl_rules = [
    {
      # Allow all inner-vpc inbound traffic.
      action      = "allow"
      cidr_block  = var.cidr
      from_port   = 0
      protocol    = -1
      rule_number = 100
      to_port     = 0
    },
    {
      # Allow inbound traffic on port 443.
      action      = "allow"
      cidr_block  = "0.0.0.0/0"
      from_port   = 443
      protocol    = 6
      rule_number = 110
      to_port     = 443
    },
    {
      # Allow inbound traffic on port 80.
      action      = "allow"
      cidr_block  = "0.0.0.0/0"
      from_port   = 80
      protocol    = 6
      rule_number = 110
      to_port     = 80
    }
  ]
}

module "endpoints" {
  source  = "terraform-aws-modules/vpc/aws//modules/vpc-endpoints"
  version = "~> 5.8"

  vpc_id = module.vpc.vpc_id
  endpoints = {
    s3 = {
      service = "s3"
      tags = { Name = "${local.prefix}-s3" }
    },
    ssm = {
      service             = "ssm"
      tags = { Name = "${local.prefix}-ssm" }
      subnet_ids          = module.vpc.private_subnets
      private_dns_enabled = true
    },
    ssmmessages = {
      service             = "ssmmessages"
      tags = { Name = "${local.prefix}-ssmmessages" }
      subnet_ids          = module.vpc.private_subnets
      private_dns_enabled = true
    },
    ec2 = {
      service             = "ec2"
      tags = { Name = "${local.prefix}-ec2" }
      subnet_ids          = module.vpc.private_subnets
      private_dns_enabled = true
    },
    ec2messages = {
      service             = "ec2messages"
      tags = { Name = "${local.prefix}-ec2messages" }
      subnet_ids          = module.vpc.private_subnets
      private_dns_enabled = true
    },
  }
}
