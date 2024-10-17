# Creating a New Module

[:material-github: Create repository from template][create-repo]{ .md-button .md-button--primary }

To create a new module for OpenTofu, you can get started quickly with the
[template repository].

## Using the template repository

Follow the steps below to create a new module using the template repository:

!!! tip inline end
    Make sure you update any references to `tofu-modules-templates` with
    your new repository name.

1. Click the button above to create a new repository from the template
1. Name your new repository using the format `tofu-modules-<provider>-<module>`
1. Add the files necessary to support your module to the root of the new
   repository
1. Update the `README.md` file with the appropriate information for your module.

## Publishing your module

[//]: # (TODO: Add a note about using submodules and snippets)
[//]: # (TODO: Add documentation about creating a release)

1. Create a release of your module
1. Update the [codeforamerica/tofu-modules][tofu-modules] repository
   1. Add your new module in the main `README.md`
   2. Add a new page under the `docs/modules` folder with the documentation for
      your module


[create-repo]: https://github.com/new?template_name=tofu-modules-template&template_owner=codeforamerica
[template]: https://github.com/codeforamerica/tofu-modules-template
[tofu-modules]: https://github.com/codeforamerica/tofu-modules
