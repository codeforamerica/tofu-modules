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

| Name           | Description                                                                                         | Type           | Default | Required |
|----------------|-----------------------------------------------------------------------------------------------------|----------------|---------|----------|
| domain         | Primary domain for the distribution. The hosted zone for this domain should be in the same account. | `string`       | n/a     | yes      |
| log_bucket     | Domain name of the S3 bucket to send logs to.                                                       | `string`       | n/a     | yes      |
| project        | The name of the project.                                                                            | `string`       | n/a     | yes      |
| environment    | The environment for the project.                                                                    | `string`       | `"dev"` | no       |
| [ip_set_rules] | The environment for the project.                                                                    | `map(object)`  | `"dev"` | no       |
| log_group      | CloudWatch log group to send WAF logs to.                                                           | `list(string)` | `[]`    | no       |
| origin_domain  | Fully qualified domain name for the origin. Defaults to `origin.${subdomain}.${domain}`.            | `string`       | n/a     | no       |
| subdomain      | Subdomain for the distribution. Defaults to the environment.                                        | `string`       | n/a     | no       |
| tags           | Optional tags to be applied to all resources.                                                       | `list`         | `[]`    | no       |

### ip_set_rules

To allow or deny traffic based on IP address, you can specify a map of [IP set
rules][ip-rules] to create. You will need to create the IP set in your
configuration, and provide the ARN of the resource. An IP set can be created
with the [`wafv2_ip_set`][wafv2_ip_set] resource.

For example:

```hcl
resource "aws_wafv2_ip_set" "security_scanners" {
  name               = "my-project-staging-security-scanners"
  description        = "Security scanners that are allowed to access the site."
  scope              = "CLOUDFRONT"
  ip_address_version = "IPV4"
  addresses          = [
    "1.2.3.4/32",
    "5.6.7.8/32"
  ]
}

module "cloudfront_waf" {
  source = "github.com/codeforamerica/tofu-modules/aws/cloudfront_waf"

  project     = "my-project"
  environment = "staging"
  domain      = "my-project.org"
  log_bucket  = module.logging.bucket

  ip_set_rules = {
    scanners = {
      name = "my-project-staging-security-scanners"
      priority = 0
      action = "allow"
      arn = aws_wafv2_ip_set.security_scanners.arn
    }
  }
}
```


[distribution]: https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/distribution-working-with.html
[ip-rules]: https://docs.aws.amazon.com/waf/latest/developerguide/waf-rule-statement-type-ipset-match.html
[ip_set_rules]: #ip_set_rules
[wafv2_ip_set]: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/wafv2_ip_set
