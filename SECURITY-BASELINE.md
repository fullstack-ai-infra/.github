# ByteFolk Security Baseline

This is the organization baseline for public ByteFolk repositories. It is a
defense-in-depth control set; a green check is evidence about the checked
commit and scope, not a guarantee that the application is secure.

## Adoption order

1. Enable GitHub Secret Scanning and Push Protection for every public
   repository. Restrict bypass to a small maintainer group and rotate any
   credential that was exposed, even when the alert is later dismissed.
2. Enable Dependabot alerts and security updates. Configure version updates
   for the repository's package managers and for GitHub Actions.
3. Add the `ByteFolk Security Baseline` workflow template. Set the CodeQL
   language matrix to the languages actually present in the repository.
4. Add the `ByteFolk Scorecard` workflow template on the default branch and a
   scheduled run.
5. Require the security checks, the repository CI, the linked issue, and the
   applicable CODEOWNER approval in the repository ruleset.
6. Add artifact attestations to release workflows and verify them before
   publishing or consuming release assets.

## Non-negotiable workflow rules

- Pin every third-party Action to a full 40-character commit SHA. Keep the
  human-readable release tag in a same-line comment so Dependabot can update
  it.
- Set `permissions: contents: read` at workflow scope and grant additional
  permissions only to the individual job that needs them.
- Do not use `pull_request_target` to check out or execute pull-request code.
- Do not expose release, cloud, package-publishing, OIDC, or model-provider
  credentials to tests or scanners that execute repository code.
- Do not use mutable Action refs, Docker `latest` tags, remote install pipes,
  or unreviewed downloaded binaries in a security gate.
- Optional third-party workflow linters such as zizmor must be reviewed
  separately; they are not part of the blocking baseline until their complete
  download and execution chain is approved.
- Treat a scanner execution error, incomplete result, or missing artifact as a
  failed gate. Do not convert it into a warning silently.

## Scope boundary

GitHub Actions run on a GitHub-hosted runner and receive only the repository
contents checked out by the workflow plus explicitly supplied variables and
secrets. They do not have access to the maintainer's local home directory.
Local scanners are a separate trust boundary. Before using one, follow
[`LOCAL-DATA-BOUNDARY.md`](LOCAL-DATA-BOUNDARY.md) and run the local boundary
check from inside the intended repository.

## AI and dynamic scanners

AI-driven or actively probing tools such as Strix are optional additions, not
part of this baseline. If one is adopted later, run it in an isolated,
ephemeral staging environment with synthetic data, no release credentials,
an approved model endpoint, telemetry disabled where policy requires it, and
an explicit egress allowlist. It must not run from the workspace root or from
a directory containing unrelated local repositories.
