# AWS Serverless Database Module

This module launches an [Aurora Serverless v2][aurora-serverless] database
cluster. Aurora serverless clusters measure capacity in [ACUs] (Aurora Capacity
Units); each unit is approximately 2 GB of memory with corresponding CPU and
networking.

## Usage

Add this module to your `main.tf` (or appropriate) file and configure the inputs
to match your desired configuration. For example:

```hcl
module "database" {
  source = "github.com/codeforamerica/tofu-modules/aws/serverless_database"

  logging_key_arn = module.logging.kms_key_arn
  secrets_key_arn = module.secrets.kms_key_arn
  vpc_id = module.vpc.vpc_id
  subnets = module.vpc.private_subnets
  ingress_cidrs = module.vpc.private_subnets_cidr_blocks

  min_capacity = 2
  max_capacity = 32

  project                = "my-project"
  environment            = "dev"
  service                = "web"
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

| Name                | Description                                                                                                                                | Type     | Default | Required |
|---------------------|--------------------------------------------------------------------------------------------------------------------------------------------|----------|---------|----------|
| logging_key_arn     | ARN of the KMS key for logging.                                                                                                            | `string` | n/a     | yes      |
| ingress_cidrs       | List of CIDR blocks to allow ingress. This is typically your private subnets.                                                              | `list`   | n/a     | yes      |
| project             | Name of the project.                                                                                                                       | `string` | n/a     | yes      |
| secrets_key_arn     | ARN of the KMS key for secrets. This will be used to encrypt database credentials.                                                         | `string` | n/a     | yes      |
| subnets             | List of subnet ids the database instances may be placed in.                                                                                | `list`   | n/a     | yes      |
| vpc_id              | Id of the VPC to launch the database cluster into.                                                                                         | `string` | n/a     | yes      |
| apply_immediately   | Whether to apply changes immediately rather than during the next maintenance window. WARNING: This may result in a restart of the cluster! | `bool`   | `false` | no       |
| environment         | Environment for the project.                                                                                                               | `string` | `"dev"` | no       |
| key_recovery_period | Recovery period for deleted KMS keys in days. Must be between 7 and 30.                                                                    | `number` | `30`    | no       |
| min_capacity        | Minimum capacity for the serverless cluster in ACUs.                                                                                       | `number` | `2`     | no       |
| max_capacity        | Maximum capacity for the serverless cluster in ACUs.                                                                                       | `number` | `10`    | no       |
| service             | Optional service that these resources are supporting. Example: 'api', 'web', 'worker'                                                      | `string` | `""`    | no       |
| skip_final_snapshot | Whether to skip the final snapshot when destroying the database cluster.                                                                   | `bool`   | `false` | no       |
| snapshot_identifier | Optional name or ARN of the snapshot to restore the cluster from. Only applicable on create.                                               | `bool`   | `false` | no       |


## Outputs

| Name             | Description                                      | Type     |
|------------------|--------------------------------------------------|----------|
| cluster_endpoint | DNS endpoint to connect to the database cluster. | `string` |
| secret_arn       | ARN of the secret holding database credentials.  | `string` |

[acus]: https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/aurora-serverless-v2.how-it-works.html#aurora-serverless-v2.how-it-works.capacity
[aurora-serverless]: https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/aurora-serverless-v2.html
