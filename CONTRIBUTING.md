# Contributing

## Commit message format

All commit messages should follow the [Conventional Commits][commits] format.
This format allows us to automatically generate changelogs and version numbers
based on the commit messages.

Common commit types include:

* `fix`: A bug fix
* `feat`: A new feature
* `ci`: Changes to CI/CD
* `docs`: Changes to documentation

adding `!` after the type indicates a breaking change. For example, `feat!`
would indicate a new feature that breaks existing functionality, and would
therefore require a major version bump.

`bump` is a special type used to indicate a version bump. This is used by the
automated release process, and should be avoided in normal commits.

## Coding standards

Code should follow the [OpenTofu style conventions][style]. This ensures that
all code is consistent and easy to read and maintain.

To make resources easier to find, you may group them together in a single file
within your module. For example, while `main.tf` handles the main configuration,
you may create a `dns.tf` file to handle all DNS-related resources.

Additionally, the following should be grouped together within their own files:

* `data.tf` for data sources
* `local.tf` for local values
* `output.tf` for outputs

## Code reviews

All code should be contributing in the form of a pull request. Pull requests
should have an approval from _at least_ one required reviewer as defined in the
`CODEOWNERS` file. Additional reviews are welcome, and may be requested by
either the submitter or the required reviewer.

[commits]: https://www.conventionalcommits.org/en/v1.0.0/
[style]: https://opentofu.org/docs/language/syntax/style/
