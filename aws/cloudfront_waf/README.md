# CloudFront WAF Module

This module creates a CloudFront [distribution] that passes traffic through a
Web Application Firewall (WAF) _without_ caching.

## Usage

Add this module to your `main.tf` (or appropriate) file and configure the inputs
to match your desired configuration. For example, to create a new distribution
`my-project.org` that points to `origin.my-project.org`, you could use:

```hcl
module "cloudfront_waf" {
  source = "github.com/codeforamerica/tofu-modules/aws/cloudfront_waf"

  project     = "my-project"
  environment = "dev"
  domain      = "my-project.org"
  log_bucket  = module.logging.bucket
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

| Name          | Description                                                                                         | Type     | Default | Required |
|---------------|-----------------------------------------------------------------------------------------------------|----------|---------|----------|
| domain        | Primary domain for the distribution. The hosted zone for this domain should be in the same account. | `string` | n/a     | yes      |
| log_bucket    | Domain name of the S3 bucket to send logs to.                                                       | `string` | n/a     | yes      |
| project       | The name of the project.                                                                            | `string` | n/a     | yes      |
| environment   | The environment for the project.                                                                    | `string` | `"dev"` | no       |
| origin_domain | Fully qualified domain name for the origin. Defaults to `origin.${subdomain}.${domain}`.            | `string` | n/a     | no       |
| subdomain     | Subdomain for the distribution. Defaults to the environment.                                        | `string` | n/a     | no       |
| tags          | Optional tags to be applied to all resources.                                                       | `list`   | `[]`    | no       |

[distribution]: https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/distribution-working-with.html
