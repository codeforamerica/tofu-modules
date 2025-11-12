# Tofu Modules

This repository includes a collection of [OpenTofu] modules that are used across
multiple projects at Code for America. The modules are organized by provider,
and each module should include its own README with usage instructions.

All modules _should_ be compatible with OpenTofu, and it's equivalent version of
terraform.

## Modules

| Provider | Module                                         | Description                                                              | Latest Version                                                                        |
|----------|------------------------------------------------|--------------------------------------------------------------------------|---------------------------------------------------------------------------------------|
| Aptible  | [managed_endpoint][aptible-managed-endpoint]   | Managed HTTPS endpoint for Aptible.                                      | [![GitHub Release][aptible-managed-endpoint-badge]][aptible-managed-endpoint-release] |
| AWS      | [backend][aws-backend]                         | S3 storage backend for tfstate.                                          | [![GitHub Release][aws-backend-badge]][aws-backend-release]                           |
| AWS      | [cloudfront_waf][aws-cloudfront-waf]           | CloudFront distribution that passes traffic through WAF without caching. | [![GitHub Release][aws-cloudfront-waf-badge]][aws-cloudfront-waf-release]             |
| AWS      | [doppler][aws-doppler]                         | Doppler sync for AWS Secrets Manager.                                    | [![GitHub Release][aws-doppler-badge]][aws-doppler-release]                           |
| AWS      | [fargate_service][aws-fargate-service]         | ECS Fargate container hosting service.                                   | [![GitHub Release][aws-fargate-service-badge]][aws-fargate-service-release]           |
| AWS      | [logging][aws-logging]                         | Basic logging configurations for AWS.                                    | [![GitHub Release][aws-logging-badge]][aws-logging-release]                           |
| AWS      | [secrets][aws-secrets]                         | Manage secrets using AWS Secrets Manager.                                | [![GitHub Release][aws-secrets-badge]][aws-secrets-release]                           |
| AWS      | [serverless_database][aws-serverless-database] | Aurora Serverless database cluster.                                      | [![GitHub Release][aws-serverless-database-badge]][aws-serverless-database-release]   |
| AWS      | [ssm_bastion][aws-ssm-bastion]                 | Use Systems Manager (SSM) and EC2 as a bastion.                          | [![GitHub Release][aws-ssm-bastion-badge]][aws-ssm-bastion-release]                   |
| AWS      | [ssm_inputs][aws-ssm-inputs]                   | Use SSM parameter store to read inputs for your infrastructure.          | [![GitHub Release][aws-ssm-inputs-badge]][aws-ssm-inputs-release]                     |
| AWS      | [ssm_outputs][aws-ssm-outputs]                 | Use SSM parameter store to store outputs to be used by other confgs.     | [![GitHub Release][aws-ssm-outputs-badge]][aws-ssm-outputs-release]                   |
| AWS      | [vpc][aws-vpc]                                 | AWS VPC configuration with networking.                                   | [![GitHub Release][aws-vpc-badge]][aws-vpc-release]                                   |
| Datadog  | [waf][datadog-waf]                             | Datadog dashboard for monitoring AWS WAF.                                | [![GitHub Release][datadog-waf-badge]][datadog-waf-release]                           |

## Contributing

Follow the [contributing guidelines][contributing] to contribute to this
repository, or any of the OpenTofu module repositories.

[aptible-managed-endpoint]: https://github.com/codeforamerica/tofu-modules-aws-cloudfront-waf
[aptible-managed-endpoint-badge]: https://img.shields.io/github/v/release/codeforamerica/tofu-modules-aws-fargate-service?logo=github&label=Latest%20Release
[aptible-managed-endpoint-release]: https://github.com/codeforamerica/tofu-modules-aws-fargate-service/releases/latest
[aws-backend]: https://github.com/codeforamerica/tofu-modules-aws-backend
[aws-backend-badge]: https://img.shields.io/github/v/release/codeforamerica/tofu-modules-aws-backend?logo=github&label=Latest%20Release
[aws-backend-release]: https://github.com/codeforamerica/tofu-modules-aws-backend/releases/latest
[aws-cloudfront-waf]: https://github.com/codeforamerica/tofu-modules-aws-cloudfront-waf
[aws-cloudfront-waf-badge]: https://img.shields.io/github/v/release/codeforamerica/tofu-modules-aws-cloudfront-waf?logo=github&label=Latest%20Release
[aws-cloudfront-waf-release]: https://github.com/codeforamerica/tofu-modules-aws-cloudfront-waf/releases/latest
[aws-doppler]: https://github.com/codeforamerica/tofu-modules-aws-doppler
[aws-doppler-badge]: https://img.shields.io/github/v/release/codeforamerica/tofu-modules-aws-doppler?logo=github&label=Latest%20Release
[aws-doppler-release]: https://github.com/codeforamerica/tofu-modules-aws-doppler/releases/latest
[aws-fargate-service]: https://github.com/codeforamerica/tofu-modules-aws-fargate-service
[aws-fargate-service-badge]: https://img.shields.io/github/v/release/codeforamerica/tofu-modules-aws-fargate-service?logo=github&label=Latest%20Release
[aws-fargate-service-release]: https://github.com/codeforamerica/tofu-modules-aws-fargate-service/releases/latest
[aws-logging]: https://github.com/codeforamerica/tofu-modules-aws-logging
[aws-logging-badge]: https://img.shields.io/github/v/release/codeforamerica/tofu-modules-aws-logging?logo=github&label=Latest%20Release
[aws-logging-release]: https://github.com/codeforamerica/tofu-modules-aws-logging/releases/latest
[aws-secrets]: https://github.com/codeforamerica/tofu-modules-aws-secrets
[aws-secrets-badge]: https://img.shields.io/github/v/release/codeforamerica/tofu-modules-aws-secrets?logo=github&label=Latest%20Release
[aws-secrets-release]: https://github.com/codeforamerica/tofu-modules-aws-secrets/releases/latest
[aws-serverless-database]: https://github.com/codeforamerica/tofu-modules-aws-serverless-database
[aws-serverless-database-badge]: https://img.shields.io/github/v/release/codeforamerica/tofu-modules-aws-serverless-database?logo=github&label=Latest%20Release
[aws-serverless-database-release]: https://github.com/codeforamerica/tofu-modules-aws-serverless-database/releases/latest
[aws-ssm-bastion]: https://github.com/codeforamerica/tofu-modules-aws-ssm-bastion
[aws-ssm-bastion-badge]: https://img.shields.io/github/v/release/codeforamerica/tofu-modules-aws-ssm-bastion?logo=github&label=Latest%20Release
[aws-ssm-bastion-release]: https://github.com/codeforamerica/tofu-modules-aws-ssm-bastion/releases/latest
[aws-ssm-inputs]: https://github.com/codeforamerica/tofu-modules-aws-ssm-inputs
[aws-ssm-inputs-badge]: https://img.shields.io/github/v/release/codeforamerica/tofu-modules-aws-ssm-inputs?logo=github&label=Latest%20Release
[aws-ssm-inputs-release]: https://github.com/codeforamerica/tofu-modules-aws-ssm-inputs/releases/latest
[aws-ssm-outputs]: https://github.com/codeforamerica/tofu-modules-aws-ssm-outputs
[aws-ssm-outputs-badge]: https://img.shields.io/github/v/release/codeforamerica/tofu-modules-aws-ssm-outputs?logo=github&label=Latest%20Release
[aws-ssm-outputs-release]: https://github.com/codeforamerica/tofu-modules-aws-ssm-outputs/releases/latest
[aws-vpc]: https://github.com/codeforamerica/tofu-modules-aws-vpc
[aws-vpc-badge]: https://img.shields.io/github/v/release/codeforamerica/tofu-modules-aws-vpc?logo=github&label=Latest%20Release
[aws-vpc-release]: https://github.com/codeforamerica/tofu-modules-aws-vpc/releases/latest
[contributing]: CONTRIBUTING.md
[datadog-waf]: https://github.com/codeforamerica/tofu-modules-datadog-waf
[datadog-waf-badge]: https://img.shields.io/github/v/release/codeforamerica/tofu-modules-datadog-waf?logo=github&label=Latest%20Release
[datadog-waf-release]: https://github.com/codeforamerica/tofu-modules-datadog-waf/releases/latest
[opentofu]: https://opentofu.org/
[terraform]: https://www.terraform.io/
