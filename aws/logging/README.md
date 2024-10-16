# AWS Logging Module

[![Main Checks](https://github.com/codeforamerica/tofu-modules-aws-logging/actions/workflows/main.yaml/badge.svg)](https://github.com/codeforamerica/tofu-modules-aws-logging/actions/workflows/main.yaml) ![GitHub Release](https://img.shields.io/github/v/release/codeforamerica/tofu-modules-aws-logging?logo=github&label=Latest%20Release)

This module created an S3 bucket for logging, as well as a KMS for CloudWatch
logs.

_Note: The bucket created by this module uses AES256 encryption. CMKs (Customer
Managed Keys) are [not supported] for access logging._

## Usage

Add this module to your `main.tf` (or appropriate) file and configure the inputs
to match your desired configuration. For example:

```hcl
module "logging" {
  source = "github.com/codeforamerica/tofu-modules-aws-logging"

  project     = "my-project"
  environment = "dev"
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

| Name                     | Description                                                                             | Type           | Default | Required |
|--------------------------|-----------------------------------------------------------------------------------------|----------------|---------|----------|
| project                  | Name of the project.                                                                    | `string`       | n/a     | yes      |
| cloudwatch_log_retention | Number of days to retain logs in CloudWatch.                                            | `number`       | `30`    | no       |
| environment              | Environment for the project.                                                            | `string`       | `"dev"` | no       |
| key_recovery_period      | Number of days to recover the KMS key after deletion.                                   | `number`       | `30`    | yes      |
| [log_groups]             | List of CloudWatch log groups to create.                                                | `list(string)` | `[]`    | no       |
| log_groups_to_datadog    | Send CloudWatch logs to Datadog. The Datadog forwarder must have already been deployed. | `bool`         | `true`  | no       |
| tags                     | Optional tags to be applied to all resources.                                           | `list`         | `[]`    | no       |

### log_groups

You can specify a list of CloudWatch log groups to create, with customized
options for each log group. If no `retention` is specified, the value provided
to `cloudwatch_log_retention` will be used.

```hcl
log_groups = {
    "/sample/log/group" = {},
    "waf" = {
      name = "aws-waf-logs-cfa/waf/demo"
      tags = { source = "waf" }
    }
  }
```

The following options are available for each log group:

| Name      | Description                                                                      | Type          | Default                        | Required |
|-----------|----------------------------------------------------------------------------------|---------------|--------------------------------|----------|
| class     | Storage class for the log group. Options are `STANDARD` and `INFREQUENT_ACCESS`. | `string`      | `"STANDARD"`                   | no       |
| name      | Name of the log group. Defaults to the key from the map.                         | `string`      | `each.key`                     | no       |
| retention | Retention period for logs.                                                       | `string`      | `var.cloudwatch_log_retention` | no       |
| tags      | Map of tags to add to the log group. Will be merged with `tags`.                 | `map(stirng)` | `{}`                           | no       |

## Outputs

| Name               | Description                                     | Type          |
|--------------------|-------------------------------------------------|---------------|
| bucket             | Name of the S3 bucket for logging.              | `string`      |
| bucket_domain_name | FQDN of the bucket.                             | `string`      |
| datadog_lambda     | ARN of the Datadog lambda forwarder, if in use. | `string`      |
| kms_key_alias      | Alias of the KMS encryption key.                | `string`      |
| kms_key_arn        | ARN of the KMS encryption key.                  | `string`      |
| log_groups         | Map of log group names and ARNs.                | `map(string)` |

[log_groups]: #log_groups
[not supported]: https://repost.aws/knowledge-center/s3-server-access-log-not-delivered
