# ByteFolk organization defaults

This repository contains ByteFolk's public organization profile and the
community health defaults inherited by repositories under the current
`fullstack-ai-infra` GitHub handle that do not define their own local versions.

- [`profile/README.md`](profile/README.md) renders on the organization page.
- [`GOVERNANCE.md`](GOVERNANCE.md) defines roles, decisions, access, and the
  boundary between organization defaults and repository overrides.
- [`CONTRIBUTING.md`](CONTRIBUTING.md) defines the issue-first contribution
  lifecycle.
- [`ENGINEERING.md`](ENGINEERING.md) defines the operational engineering
  standards: language and attribution policy, mandatory testing, issue
  governance, pull request gates, and code review rules.
- [`RELEASING.md`](RELEASING.md) defines the organization-wide release
  process: SemVer, immutable-tag verification, declared distribution channels,
  and evidence-backed `N/A` handling for unsupported channels.
- [`SECURITY.md`](SECURITY.md), [`SUPPORT.md`](SUPPORT.md), and
  [`CODE_OF_CONDUCT.md`](CODE_OF_CONDUCT.md) provide default community routes.
- [`LICENSE`](LICENSE) licenses this governance repository under Apache-2.0; it
  is not inherited as another repository's project license.
- [`.github/ISSUE_TEMPLATE`](.github/ISSUE_TEMPLATE) and
  [`PULL_REQUEST_TEMPLATE.md`](PULL_REQUEST_TEMPLATE.md) provide default forms.

Repository-specific CI commands, labels, CODEOWNERS, release automation,
secrets, and required checks remain in each project.

This repository's own CODEOWNERS and validation workflow govern changes here
only; GitHub does not inherit them as community-health defaults.

Changes to these defaults follow
[Issue → branch → pull request → CI → independent review → squash](CONTRIBUTING.md).
