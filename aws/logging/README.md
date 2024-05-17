# AWS Logging Module

This module created an S3 bucket for logging, as well as a KMS for CloudWatch
logs.

_Note: The bucket created by this module uses AES256 encryption. CMKs (Customer
Managed Keys) are [not supported] for access logging._

## Usage

Add this module to your `main.tf` (or appropriate) file and configure the inputs
to match your desired configuration. For example:

```hcl
module "cloudfront_waf" {
  source = "github.com/codeforamerica/tofu-modules/aws/logging"

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

| Name                | Description                                           | Type     | Default | Required |
|---------------------|-------------------------------------------------------|----------|---------|----------|
| project             | Name of the project.                                  | `string` | n/a     | yes      |
| environment         | Environment for the project.                          | `string` | `"dev"` | no       |
| key_recovery_period | Number of days to recover the KMS key after deletion. | `number` | 30      | yes      |

## Outputs

| Name          | Description                        | Type     |
|---------------|------------------------------------|----------|
| bucket        | Name of the S3 bucket for logging. | `string` |
| kms_key_alias | Alias of the KMS encryption key.   | `string` |
| kms_key_arn   | ARN of the KMS encryption key.     | `string` |

[not supported]: https://repost.aws/knowledge-center/s3-server-access-log-not-delivered
