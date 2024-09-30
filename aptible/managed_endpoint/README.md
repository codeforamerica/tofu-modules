# Aptible Managed Endpoint Module

This module creates a [managed HTTPS endpoint][endpoint] in Aptible. It will
also create the necessary DNS records in Route 53 to verify the domain and
direct it to the endpoint.

## Usage

Add this module to your `main.tf` (or appropriate) file and configure the inputs
to match your desired configuration. For example:

```hcl
module "endpoint" {
  source = "github.com/codeforamerica/tofu-modules/aptible/managed_endpoint"

  aptible_environment = "my-environment"
  aptible_resource = 12345
  domain = "my-project.org"
  subdomain = "www"
  public = true
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

| Name                | Description                                                                         | Type           | Default | Required |
|---------------------|-------------------------------------------------------------------------------------|----------------|---------|----------|
| aptible_environment | Name of the Aptible environment for the endpoint.                                   | `string`       | n/a     | yes      |
| aptible_resource    | ID of the resource to attach the endpoint to.                                       | `number`       | n/a     | yes      |
| domain              | Top-level domain name for the endpoint. This will be used to find the Route53 zone. | `string`       | n/a     | yes      |
| subdomain           | Subdomain for the endpoint. This will be prepended to the domain.                   | `string`       | n/a     | yes      |
| allowed_cidrs       | An optional lit of CIDRs to allow traffic from (limited to 50 entries).             | `list(string)` | `[]`    | no       |
| public              | Whether the endpoint should be available to the public Internet.                    | `bool`         | `false` | no       |

## Outputs

| Name     | Description                                         | Type     |
|----------|-----------------------------------------------------|----------|
| id       | Id of the Aptible endpoint.                         | `string` |
| fqdn     | Fully qualified domain name for the HTTPS endpoint. | `number` |
| hostname | Hostname of the endpoint that was created.          | `string` |

[endpoint]: https://www.aptible.com/docs/core-concepts/apps/connecting-to-apps/app-endpoints/https-endpoints/overview
