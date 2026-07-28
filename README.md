# fullstack-ai-infra organization defaults

This repository contains the public organization profile and the community
health defaults inherited by `fullstack-ai-infra` repositories that do not
define their own local versions.

- [`profile/README.md`](profile/README.md) renders on the organization page.
- [`GOVERNANCE.md`](GOVERNANCE.md) defines roles, decisions, access, and the
  boundary between organization defaults and repository overrides.
- [`CONTRIBUTING.md`](CONTRIBUTING.md) defines the issue-first contribution
  lifecycle.
- [`SECURITY.md`](SECURITY.md), [`SUPPORT.md`](SUPPORT.md), and
  [`CODE_OF_CONDUCT.md`](CODE_OF_CONDUCT.md) provide default community routes.
- [`LICENSE`](LICENSE) licenses this governance repository under Apache-2.0; it
  is not inherited as another repository's project license.
- [`.github/ISSUE_TEMPLATE`](.github/ISSUE_TEMPLATE) and
  [`PULL_REQUEST_TEMPLATE.md`](PULL_REQUEST_TEMPLATE.md) provide default forms.

Repository-specific CI commands, labels, CODEOWNERS, release automation,
secrets, and required checks remain in each project.

Changes to these defaults follow
[Issue → branch → pull request → CI → independent review → squash](CONTRIBUTING.md).
