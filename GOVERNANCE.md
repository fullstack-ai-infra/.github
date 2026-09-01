# Governance

This document defines the organization-wide governance baseline for ByteFolk
projects. It explains which defaults are inherited from this
repository and which decisions belong to each project.

## Principles

- **Open decisions:** Record material technical and governance decisions where
  contributors can find and review them.
- **Issue-first changes:** Agree on the problem, scope, and acceptance criteria
  before implementation.
- **Independent review:** The sole author cannot supply the approval required
  for their own change.
- **Evidence over assertion:** Tests, traces, reproducible checks, and review
  records support important claims.
- **Least privilege:** Grant only the access needed for a role and review access
  as responsibilities change.
- **Reversibility:** Prefer small changes with clear rollback paths.

## Roles

### Contributors

Anyone who reports issues, proposes changes, improves documentation, reviews
work, or otherwise helps a project. Contributors are responsible for following
the affected repository's policies and the Code of Conduct.

### Repository maintainers

Maintainers triage issues, confirm readiness, review changes, manage repository
settings, and merge approved pull requests. A repository should document who
holds this role and how ownership changes.

Maintainers must disclose conflicts of interest and recuse themselves when they
cannot provide an independent decision.

### Organization owners and security managers

Organization owners steward organization-wide policy, repository lifecycle,
membership, and high-risk access. Security managers coordinate private
vulnerability handling across repositories. These roles do not replace
repository maintainers for ordinary technical decisions.

## Decision making

Prefer consensus supported by documented constraints and evidence. When
consensus is not practical, the responsible maintainer makes the decision,
records the rationale and material objections, and identifies follow-up work.

Organization-wide policy changes require:

1. a public issue describing the problem, scope, and compatibility impact;
2. a focused branch and pull request;
3. passing required checks;
4. approval from someone other than the sole author; and
5. squash merge after conversations are resolved.

Private security matters use a repository security advisory until coordinated
disclosure is safe.

## Confidential intake

GitHub provides repository-scoped private vulnerability reporting, but this
organization does not yet have a separate general-purpose confidential conduct
inbox. The `.github` repository's private advisory form is therefore shared as
the temporary confidential intake route. A `CONDUCT:` title prefix separates
conduct reports from vulnerability reports; using the same transport does not
make a conduct report a vulnerability.

Organization owner `PeterGuy326` is currently the sole confidential handler.
Until a second independent handler with two-factor authentication is appointed,
the organization cannot independently handle a report involving that owner.
For conduct on GitHub, reporters should use GitHub's
[Report Abuse or Support process](https://docs.github.com/en/communities/maintaining-your-safety-on-github/reporting-abuse-or-spam).
The recusal requirement begins once a second independent handler is in place.

## Organization defaults and repository overrides

This public `.github` repository supplies default community health files to
organization repositories that do not define their own corresponding files.

| Organization default | Repository-owned detail |
| --- | --- |
| Contribution lifecycle and review baseline | Setup commands, required CI checks, branch naming, and technical validation |
| Code of Conduct | Additional community channels and named confidential contacts |
| Security reporting route | Supported versions, product scope, response targets, and repository-specific contacts |
| Support expectations | Project support channels, service levels, and maintained versions |
| General issue and PR forms | Labels, issue types, component choices, maintainers, and specialized questions |
| Governance principles | Project roles, decision owners, release policy, and escalation paths |

A repository-local file with the same purpose takes precedence over the
organization default. Repository policy may strengthen or specialize the
baseline but should preserve the core issue, branch, pull request, CI,
independent-review, and squash-merge sequence. A genuine exception requires an
organization governance issue, organization-owner approval, and a repository
governance record naming the owner and rationale.

GitHub treats issue templates as a directory-level override: when a repository
adds any file to its own `.github/ISSUE_TEMPLATE` directory, it replaces the
organization's default issue-template set rather than inheriting individual
missing templates. Repository maintainers who override one issue form should
therefore provide the complete set they intend contributors to use.

Organization-wide issue and pull request templates require this `.github`
repository to remain public. Repository-specific CI workflows, ownership files,
labels, rulesets, release automation, and secrets belong in the affected
repository and are not supplied as organization defaults here. This governance
repository may define its own validation workflow and ownership file; those
apply only to this repository.

## Controlled exceptions

Exceptions exist to make the baseline operable, not optional. Use the narrowest
applicable case and retain an auditable record.

### Repository bootstrap

An organization owner may create a repository and seed its default branch with
the minimum files required to enable issues, protections, and the first pull
request. They must then open a bootstrap issue, add another reviewer with the
necessary access, protect the default branch, and move all subsequent work
through the normal workflow. Bootstrap does not authorize product development
or repeated direct pushes.

### Automated dependency updates

A trusted dependency bot may use its update record or linked public advisory as
the tracking issue instead of waiting for a separate manually triaged issue.
The pull request still requires repository CI, an independent human review, and
the normal merge protections. Automation cannot approve or merge its own
change.

### Private and emergency security work

A private security advisory is the tracking issue for embargoed work. Use a
private branch or security fork, minimize the diff, and preserve independent
review and tests whenever doing so does not increase harm.

An organization owner may invoke break-glass only to stop active exploitation,
prevent imminent data loss, or restore a disabled security control when the
normal delay would materially increase harm. The owner must record the
authorization in the private advisory, limit the bypass to the exact change and
time window, restore protections immediately, and open a sanitized
post-incident record. A non-author must review the deployed diff as soon as it
is safe, even if that review could not precede the emergency change.

### Single-maintainer projects

A repository with one maintainer may ask an organization owner or another
qualified organization maintainer for independent review. Except for the
one-time bootstrap and break-glass cases above, the absence of a second
reviewer is a staffing blocker, not permission to self-approve.

## Repository lifecycle

Creating, transferring, archiving, or deleting an organization repository
requires an organization owner and a documented purpose. Before archival,
maintainers should record replacement projects, security implications, and the
support status. Deletion requires explicit authorization and a recovery or
retention decision.

## Access and accountability

Repository access follows least privilege. Administrative access should be
limited to active maintainers who need it. Protected branches should require
pull requests, passing checks, resolved conversations, and independent review.
Force pushes and branch deletion should be disabled for protected branches
unless a repository documents a compelling exception.

Automated systems act through narrowly scoped identities and tokens. They do
not replace human accountability for authored or approved changes.

## Changing this governance

Governance evolves through the same issue, branch, pull request, CI, independent
review, and squash process required for project changes. Review this baseline
when organization responsibilities or GitHub inheritance behavior materially
changes.
