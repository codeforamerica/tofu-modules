# Tofu Modules

This repository includes a collection of [OpenTofu] modules that are used across
multiple projects at Code for America. The modules are organized by provider,
and each module should include its own README with usage instructions.

All modules _should_ be compatible with OpenTofu and it's equivalent version of
terraform.

## Modules

| Provider | Module                 | Description                     |
|----------|------------------------|---------------------------------|
| AWS      | [backend][aws-backend] | S3 storage backend for tfstate. |

[aws-backend]: ./aws/backend/README.md
[opentofu]: https://opentofu.org/
[terraform]: https://www.terraform.io/
