# AWS Fargate Service Module

This module launches a service on AWS Fargate. It creates a cluster, task
definition, service, and container repository. In addition, it creates the load
balancer, ACM certificate, Route53 records, and security groups needed to expose
the service.

## Usage

Add this module to your `main.tf` (or appropriate) file and configure the inputs
to match your desired configuration. For example:

```hcl
module "cloudfront_waf" {
  source = "github.com/codeforamerica/tofu-modules/aws/fargate_service"

  project       = "my-project"
  project_short = "my-proj"
  environment   = "dev"
  service       = "worker"
  service_short = "wrk"

  domain          = "dev.worker.my-project.org"
  vpc_id          = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets
  public_subnets  = module.vpc.public_subnets
  logging_key_id  = module.logging.kms_key_arn
  container_port  = 3000
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

| Name                     | Description                                                                            | Type     | Default    | Required |
|--------------------------|----------------------------------------------------------------------------------------|----------|------------|----------|
| domain                   | Domain name for service. Example: `"staging.service.org"`                              | `string` | n/a        | yes      |
| logging_key_id           | KMS key to use for log encryption.                                                     | `string` | n/a        | yes      |
| private_subnets          | List of private subnet CIDR blocks.                                                    | `list`   | n/a        | yes      |
| project                  | Name of the project.                                                                   | `string` | n/a        | yes      |
| project_short            | Short name for the project. Used in resource names with character limits.              | `string` | n/a        | yes      |
| public_subnets           | List of public subnet CIDR blocks.                                                     | `list`   | n/a        | yes      |
| service                  | Service that these resources are supporting. Example: `"api"`, `"web"`, `"worker"`     | `string` | n/a        | yes      |
| service_short            | Short name for the service. Used in resource names with character limits.              | `string` | n/a        | yes      |
| vpc_id                   | Id of the VPC to deploy into.                                                          | `string` | n/a        | yes      |
| container_port           | Port the container listens on.                                                         | `number` | `80`       | no       |
| environment              | Environment for the project.                                                           | `string` | `"dev"`    | no       |
| force_delete             | Force deletion of resources. If changing to true, be sure to apply before destroying.  | `bool`   | `false`    | no       |
| image_tag                | Tag of the container image to be deployed.                                             | `string` | `"latest"` | no       |
| internal                 | Creates an internal ALB instead of a public one.                                       | `bool`   | `false`    | no       |
| key_recovery_period      | Number of days to recover the service KMS key after deletion.                          | `number` | `30`       | no       |
| log_retention_period     | Retention period for flow logs, in days.                                               | `number` | `30`       | no       |
| untagged_image_retention | Retention period (after push) for untagged images, in days.                            | `number` | `14`       | no       |

## Outputs

| Name         | Description                                                  | Type     |
|--------------|--------------------------------------------------------------|----------|
| cluster_name | Name of the ECS Fargate cluster.                             | `string` |
| docker_push  | Commands to push a Docker image to the container repository. | `string` |
