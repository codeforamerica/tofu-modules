# AWS VPC Module

This module sets up a standard VPC with public and private subnets, NAT
gateway(s), service endpoints, and routing.

Creates endpoints for the following services: EC2, S3, SSM

## Usage

Add this module to your `main.tf` (or appropriate) file and configure the inputs
to match your desired configuration. For example, to create a VPC with 3 public
and private subnets, you could use the following configuration:

```hcl
module "cloudfront_waf" {
  source = "github.com/codeforamerica/tofu-modules/aws/vpc"

  project        = "my-project"
  environment    = "dev"
  cidr           = "10.0.20.0/22"
  logging_key_id = module.logging.kms_key_arn

  private_subnets = ["10.0.22.0/26", "10.0.22.64/26", "10.0.22.128/26"]
  public_subnets  = ["10.0.20.0/26", "10.0.20.64/26", "10.0.20.128/26"]
}
```

Make sure you re-run `tofu init` after adding the module to your configuration.

```bash
tofu init
tofu plan
```

To update the source for this module, pass `-upgrade` to `tofu init`:

```bash
tofu init -upgrade
```

## Inputs

| Name                 | Description                                                                                                 | Type     | Default | Required |
|----------------------|-------------------------------------------------------------------------------------------------------------|----------|---------|----------|
| cidr                 | IPv4 CIDR block for the VPC.                                                                                | `string` | n/a     | yes      |
| logging_key_id       | KMS key to use for log encryption.                                                                          | `string` | n/a     | yes      |
| private_subnets      | List of private subnet CIDR blocks.                                                                         | `list`   | n/a     | yes      |
| project              | Name of the project.                                                                                        | `string` | n/a     | yes      |
| public_subnets       | List of public subnet CIDR blocks.                                                                          | `list`   | n/a     | yes      |
| log_retention_period | Retention period for flow logs, in days.                                                                    | `string` | 30      | no       |
| environment          | Environment for the project.                                                                                | `string` | `"dev"` | no       |
| single_nat_gateway   | Create a single NAT gateway, rather than 1 in each private subnet. **_Cheaper, but not highly available._** | `bool`   | `false` | no       |

## Outputs

| Name               | Description                              | Type     |
|--------------------|------------------------------------------|----------|
| availability_zones | List of availability zones with subnets. | `list`   |
| private_subnets    | List of private subnet CIDRs.            | `list`   |
| public_subnets     | List of public subnet CIDRs.             | `list`   |
| vpc_id             | Id of the created VPC.                   | `string` |
