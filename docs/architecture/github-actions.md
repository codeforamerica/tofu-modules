# GitHub Actions

!!! info inline end "Latest Versions"
    The workflows found in the [template repository][template-flows] are the
    most up to date. Make sure to check the latest version of the template
    repository for the most recent changes.

Each module repository should contain a set of GitHub Actions workflows to
automate linting, security scanning, and releasing. These workflows are defined
in the `.github/workflows` directory of the repository.

## Branch/Main checks

These workflows, found in `branch.yaml` and `main.yaml`, run common linting and
security scanning tasks.

The branch checks run on all branches other than `main`. We run these on
branches, rather than pull request, in order to receive faster feedback without
having to open a request first.

The main checks run the same checks on the `main` branch. However, the
security results will be uploaded to GitHub's Code Scanning dashboard.

| Job     | Description                                                      |
|---------|------------------------------------------------------------------|
| `lint`  | Uses [TFLint] to lint code and ensure it follows best practices. |
| `trivy` | Uses [Trivy] to scan for vulnerabilities and misconfigurations.  |

## CodeQL analysis

This workflow uses GitHub's [CodeQL] to analyze the codebase for vulnerabilities
and exposed credentials. Although CodeQL doesn't directly support HCL, it can
still scan our JSON and YAML files for exposed credentials.

## Release

This workflow automates the release process for the module. It uses [commitizen]
to generate a changelog and version bump based on the commit messages. The
actual release process takes place over two jobs.

### build-release

The `build-release` job runs on every push to the `main` branch. It uses
[conventional commits][commits] to determine if a new version should be
released. If the commit message does indicate that a new version should be
released, the job will update the changelog, bump the version number, and create
a pull request with the changes.

The pull request will require a manual review and merge. Once merged, the
`release` job will pick up the rest of the process.

### release

The `release` job runs on `main` for any commits that start with `bump:`, to
indicate the commit is for a new version. This job will create a new tag at the
commit, push the tag to GitHub, and create a new release with the changelog
entry for the version.

[codeql]: https://codeql.github.com/
[commitizen]: https://commitizen-tools.github.io/commitizen/
[commits]: https://www.conventionalcommits.org/en/v1.0.0/
[template-flows]: https://github.com/codeforamerica/tofu-modules-template/tree/main/.github/workflows
[tflint]: https://github.com/terraform-linters/tflint
[trivy]: https://aquasecurity.github.io/trivy/v0.56/
