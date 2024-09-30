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

[aptible-managed-endpoint]: ./aptible/managed_endpoint/README.md
[aws-backend]: ./aws/backend/README.md
[aws-cloudfront-waf]: ./aws/cloudfront_waf/README.md
[aws-fargate_service]: ./aws/fargate_service/README.md
[aws-logging]: ./aws/logging/README.md
[aws-secrets]: ./aws/secrets/README.md
[aws-serverless-database]: ./aws/serverless_database/README.md
[aws-vpc]: ./aws/vpc/README.md
[opentofu]: https://opentofu.org/
[terraform]: https://www.terraform.io/
