# Architecture

## File structure

Our modules follow the [standard module structure][structure] for OpenTofu. This
ensures consistency across all modules and makes it easier to use and maintain
them.

A basic module repository should look similar to this:

!!! note inline end
    Items marked with `*` are optional and may not be present in all modules.

```
tofu-modules-sample-module
├── .cz.yaml
├── .editorconfig
├── .github
│   └── workflows
│       ├── branch.yaml
│       ├── codeql-analysis.yaml
│       ├── main.yaml
│       └── release.yaml
├── .gitignore
├── CHANGELOG.md
├── CODEOWNERS
├── LICENSE
├── README.md
├── data.tf*
├── local.tf*
├── main.tf
├── output.tf
├── trivy.yaml
├── variables.tf
└── versions.tf
```

| File/Folder     | Description                                                              |
|-----------------|--------------------------------------------------------------------------|
| `.cz.yaml`      | Configuration file for [commitizen]. Used to create automated releases.  |
| `.editorconfig` | Configuration file for code editors in the [EditorConfig] format.        |
| `.github`       | Folder containing GitHub Actions workflows.                              |
| `.gitignore`    | File containing patterns to ignore in Git.                               |
| `CHANGELOG.md`  | File containing a log of changes to the module. Automatically updated    |
| `CODEOWNERS`    | File containing the owners of the repository who are required reviewers. |
| `LICENSE`       | File containing the license for the module.                              |
| `README.md`     | File containing usage information about the module.                      |
| `data.tf`       | (Optional) File containing data sources for the module.                  |
| `local.tf`      | (Optional) File containing local values for the module.                  |
| `main.tf`       | File containing the main configuration for the module.                   |
| `output.tf`     | File containing the outputs for the module.                              |
| `trivy.yaml`    | Configuration file for Trivy, a security code scanner.                   |
| `variables.tf`  | File containing the variables for the module.                            |
| `versions.tf`   | File containing the required version of OpenTofu and any providers.      |

## Naming Conventions

Repositories should follow the naming convention
`tofu-modules-<provider>-<module>`, where `<provider>` is the primary provider
for the module (such as "aws", "aptible", or "azure") and `<module>` is a title
that sums up the purpose of your module (such as "logging" or "api-gateway").

The module name will be derived from the repository name, where the
"tofu-modules-" prefix is removed and dashes are replaced with underscores.
For example, `tofu-modules-aptible-managed-endpoint` becomes
`aptible_managed_endpoint`.

[commitizen]: https://commitizen-tools.github.io/commitizen/
[editorconfig]: https://editorconfig.org/
[structure]: https://opentofu.org/docs/v1.6/language/modules/develop/structure/
