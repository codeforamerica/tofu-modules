# Tofu Modules

This repository includes a collection of [OpenTofu] modules that are used across
multiple projects at Code for America. The modules are organized by provider,
and each module should include its own README with usage instructions.

All modules _should_ be compatible with OpenTofu, and it's equivalent version of
terraform.

## Modules

| Provider | Module                                         | Description                                                              |
|----------|------------------------------------------------|--------------------------------------------------------------------------|
| Aptible  | [managed_endpoint][aptible-managed-endpoint]   | Managed HTTPS endpoint for Aptible.                                      |
| AWS      | [backend][aws-backend]                         | S3 storage backend for tfstate.                                          |
| AWS      | [cloudfront_waf][aws-cloudfront-waf]           | CloudFront distribution that passes traffic through WAF without caching. |
| AWS      | [fargate_service][aws-fargate_service]         | ECS Fargate container hosting service.                                   |
| AWS      | [logging][aws-logging]                         | Basic logging configurations for AWS.                                    |
| AWS      | [secrets][aws-secrets]                         | Manage secrets using AWS Secrets Manager.                                |
| AWS      | [serverless_database][aws-serverless-database] | Aurora Serverless database cluster.                                      |
| AWS      | [vpc][aws-vpc]                                 | AWS VPC configuration with networking.                                   |
| Datadog  | [waf][datadog-waf]                             | Datadog dashboard for monitoring AWS WAF.                                |

## Contributing

Follow the [contributing guidelines][contributing] to contribute to this
repository, or any of the OpenTofu module repositories.

[aptible-managed-endpoint]: https://github.com/codeforamerica/tofu-modules-aws-cloudfront-waf
[aws-backend]: https://github.com/codeforamerica/tofu-modules-aws-backend
[aws-cloudfront-waf]: https://github.com/codeforamerica/tofu-modules-aws-cloudfront-waf
[aws-fargate_service]: ./aws/fargate_service/README.md
[aws-logging]: https://github.com/codeforamerica/tofu-modules-aws-logging
[aws-secrets]: https://github.com/codeforamerica/tofu-modules-aws-secrets
[aws-serverless-database]: ./aws/serverless_database/README.md
[aws-vpc]: ./aws/vpc/README.md
[contributing]: CONTRIBUTING.md
[datadog-waf]: https://github.com/codeforamerica/tofu-modules-datadog-waf
[opentofu]: https://opentofu.org/
[terraform]: https://www.terraform.io/
