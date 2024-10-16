# AWS Backend Module

[![Main Checks](https://github.com/codeforamerica/tofu-modules-aws-backend/actions/workflows/main.yaml/badge.svg)](https://github.com/codeforamerica/tofu-modules-aws-backend/actions/workflows/main.yaml) ![GitHub Release](https://img.shields.io/github/v/release/codeforamerica/tofu-modules-aws-backend?logo=github&label=Latest%20Release)

This module creates an AWS backend for OpenTofu.

## Usage

> **Note:** These steps must be completed _before_ adding the backend
> configuration to your `main.tf` file.

Add this module to your `main.tf` (or appropriate) file and configure the inputs
to match your desired configuration. For example:

```hcl
module "backend" {
  source = "github.com/codeforamerica/tofu-modules-aws-backend"

  project     = "my-project"
  environment = "dev"
}
```

Run the following commands to create the backend:

```bash
tofu init
tofu plan -out backend.tfplan
# Make sure to review the plan before applying!
tofu apply backend.tfplan
rm backend.tfplan
```

Add the backend configuration to your `main.tf` file:

```hcl
terraform {
  backend "s3" {
    bucket = "my-project-dev-tfstate"
    key    = "my-project.tfstate" # Choose an appropriate key
    region = "us-east-1"
  }
}
```

Run the following commands to initialize the backend and transfer the state
file.

```bash
tofu init -migrate-state
```

Follow the prompts to migrate the state file. Once complete, you can remove the
local state files:

```bash
rm terraform.tfstate terraform.tfstate.backup
```

You now have a fully configured AWS backend for your project!

## Inputs

| Name                | Description                                                           | Type     | Default | Required |
|---------------------|-----------------------------------------------------------------------|----------|---------|:--------:|
| project             | The name of the project.                                              | `string` | n/a     |   yes    |
| environment         | The environment for the project.                                      | `string` | `"dev"` |    no    |
| key_recovery_period | The number of days to retain the KMS key for recovery after deletion. | `number` | `30`    |    no    |
| tags                | Optional tags to be applied to all resources.                         | `list`   | `[]`    |    no    |


## Outputs

| Name    | Description                              | Type     |
|---------|------------------------------------------|----------|
| bucket  | Name of the S3 bucket for state storage. | `string` |
| kms_key | KMS key used to encrypt state.           | `string` |
