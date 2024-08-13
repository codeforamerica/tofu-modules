# AWS Fargate Service Module

This module launches a service on AWS Fargate. It creates a cluster, task
definition, service, and container repository. In addition, it creates the load
balancer, ACM certificate, Route53 records, and security groups needed to expose
the service.

## Usage

Add this module to your `main.tf` (or appropriate) file and configure the inputs
to match your desired configuration. For example:

```hcl
module "fargate_service" {
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

  environment_variables = {
    RACK_ENV = "development"
  }
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

| Name                      | Description                                                                           | Type          | Default    | Required |
|---------------------------|---------------------------------------------------------------------------------------|---------------|------------|----------|
| domain                    | Domain name for service. Example: `"staging.service.org"`                             | `string`      | n/a        | yes      |
| logging_key_id            | KMS key to use for log encryption.                                                    | `string`      | n/a        | yes      |
| private_subnets           | List of private subnet CIDR blocks.                                                   | `list`        | n/a        | yes      |
| project                   | Name of the project.                                                                  | `string`      | n/a        | yes      |
| project_short             | Short name for the project. Used in resource names with character limits.             | `string`      | n/a        | yes      |
| public_subnets            | List of public subnet CIDR blocks.                                                    | `list`        | n/a        | yes      |
| service                   | Service that these resources are supporting. Example: `"api"`, `"web"`, `"worker"`    | `string`      | n/a        | yes      |
| service_short             | Short name for the service. Used in resource names with character limits.             | `string`      | n/a        | yes      |
| vpc_id                    | Id of the VPC to deploy into.                                                         | `string`      | n/a        | yes      |
| container_port            | Port the container listens on.                                                        | `number`      | `80`       | no       |
| enable_execute_command    | Enable the [ECS ExecuteCommand][ecs-exec] feature.                                    | `bool`        | `false`    | no       |
| environment               | Environment for the project.                                                          | `string`      | `"dev"`    | no       |
| [environment_secrets]     | Secrets to be injected as environment variables into the container.                   | `map(string)` | `{}`       | no       |
| environment_variables     | Environment variables to be set on the container.                                     | `map(string)` | `{}`       | no       |
| force_delete              | Force deletion of resources. If changing to true, be sure to apply before destroying. | `bool`        | `false`    | no       |
| image_tag                 | Tag of the container image to be deployed.                                            | `string`      | `"latest"` | no       |
| image_tags_mutable        | Whether the container repository allows tags to be mutated.                           | `bool`        | `false`    | no       |
| ingress_cidrs             | List of additional CIDR blocks to allow traffic from.                                 | `list`        | `[]`       | no       |
| key_recovery_period       | Number of days to recover the service KMS key after deletion.                         | `number`      | `30`       | no       |
| log_retention_period      | Retention period for flow logs, in days.                                              | `number`      | `30`       | no       |
| otel_log_level            | Log level for the OpenTelemetry collector.                                            | `string`      | `"info"`   | no       |
| public                    | Whether the service should be exposed to the public Internet.                         | `bool`        | `false`    | no       |
| [secrets_manager_secrets] | Map of secrets to be created in Secrets Manager.                                      | `map(object)` | `{}`       | no       |
| subdomain                 | Optional subdomain for the service, to be appended to the domain for DNS.             | `string`      | `""`       | no       |
| tags                      | Optional tags to be applied to all resources.                                         | `list`        | `[]`       | no       |
| untagged_image_retention  | Retention period (after push) for untagged images, in days.                           | `number`      | `14`       | no       |

### secrets_manager_secrets

An optional map of secrets to be created in [AWS Secrets
Manager][secrets-manager]. Once the secret is created, any changes to the value
will be ignored. For example, to create a secret named `example`:

```hcl
secrets_manager_secrets = {
  example = {
    recovery_window = 7
    description = "Example credentials for our application."
  }
}
```

| Name                   | Description                                                  | Type     | Default | Required |
|------------------------|--------------------------------------------------------------|----------|---------|----------|
| description            | Description of the secret.                                   | `string` | n/a     | yes      |
| recovery_window        | Number of days that a secret can be recovered after deltion. | `string` | `30`    | no       |
| create_random_password | Creates a random password as the staring value.              | `bool`   | `false` | no       |
| start_value            | Value to be set into the secret at creation.                 | `string` | `"{}"`  | no       |

### environment_secrets

An optional map of secrets to be injected as environment variables into the
container. The key is the name of the environment variable, and the value is the
identifier and key of a secret, seperated by ":". The identifier may be the name
of a secret defined using [secrets_manager_secrets], or the full ARN of an
existing secret. For example:

```hcl
environment_secrets = {
  EXAMPLE_CLIENT_ID = "client:client_id"
  EXAMPLE_CLIENT_KEY = "arn:aws:secretsmanager:us-east-1:123456789012:secret:project/staging/client:key"
}
```

## Outputs

| Name         | Description                                                  | Type     |
|--------------|--------------------------------------------------------------|----------|
| cluster_name | Name of the ECS Fargate cluster.                             | `string` |
| docker_push  | Commands to push a Docker image to the container repository. | `string` |

[ecs-exec]: https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-exec.html
[environment_secrets]: #environment_secrets
[secrets-manager]: https://docs.aws.amazon.com/secretsmanager/latest/userguide/intro.html
[secrets_manager_secrets]: #secrets_manager_secrets
