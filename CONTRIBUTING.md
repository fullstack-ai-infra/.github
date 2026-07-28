# Contributing

Thank you for contributing to a fullstack-ai-infra project.

This file is the organization-wide baseline for repositories that do not
provide their own contribution guide. Repository-local instructions are
authoritative for technical setup, required checks, labels, maintainers, and
release policy. Local policy may strengthen or clarify this baseline but should
preserve its issue, branch, pull request, CI, independent-review, and
squash-merge sequence.

The license in the affected repository applies to contributions made there.

## Required change flow

Every repository change follows this sequence:

1. **Issue:** Search existing issues, then open or select one that describes the
   problem or desired outcome. Report vulnerabilities privately instead.
2. **Ready:** A maintainer confirms scope, acceptance criteria, dependencies,
   and a validation approach before implementation begins.
3. **Branch:** Create an issue-specific branch from the latest default branch.
   Do not develop directly on a protected branch.
4. **Implement:** Make the smallest complete change. Keep unrelated work out of
   the branch and update tests and documentation where applicable.
5. **Pull request:** Link the issue, map the change to its acceptance criteria,
   and provide reproducible validation evidence.
6. **CI:** Pass every check required by the affected repository.
7. **Independent review:** Obtain approval from someone other than the sole
   author and resolve every review conversation.
8. **Squash:** A maintainer squash-merges the approved pull request and removes
   the completed branch.

Do not use a public issue for embargoed or suspected security vulnerabilities.
Follow [SECURITY.md](SECURITY.md).

## Issues

A ready issue contains:

- a clear problem statement or desired outcome;
- objective acceptance criteria;
- included scope and explicit non-goals;
- affected users, repositories, or components;
- dependencies and material risks; and
- a practical validation plan.

Bug reports should separate expected behavior from actual behavior and include
the smallest safe reproduction available. Feature requests should lead with
the problem rather than a preferred implementation.

Questions may close when answered. If an answer requires a repository change,
create or convert it into a ready implementation issue before starting work.

## Branches and commits

Create a dedicated branch from an up-to-date default branch. Use the affected
repository's naming rules when present; otherwise use:

```text
<type>/<issue-number>-<short-description>
```

Keep commits reviewable and scoped. Do not rewrite shared history without
explicit maintainer authorization.

## Validation

Follow the affected repository's setup and test documentation. Before
requesting review:

- run every relevant formatter, linter, test, type check, build, and security
  check documented by the repository;
- add or update tests for changed behavior;
- add a regression test for a bug fix when practical;
- report coverage impact when coverage tooling exists; and
- record any check that could not be run locally, why, and which CI result
  covers it.

Never invent test output, coverage, benchmark data, or review evidence.

## Pull requests

A review-ready pull request must:

- use `Closes #<number>` when it completes the issue, or `Refs #<number>` when
  it is one part of a larger issue;
- describe what changed, why, and what remains out of scope;
- map implementation and evidence to acceptance criteria;
- include a validation ledger with expected and actual results;
- describe tests, coverage impact, compatibility, security, and operational
  risk;
- include a credible rollback plan;
- update relevant documentation and changelog files; and
- contain no secrets, personal data, generated caches, or unrelated edits.

Draft pull requests are welcome for early feedback but are not eligible for
merge. New commits after approval may require another review.

## Review and merge

Reviewers independently verify the material claims in the pull request rather
than relying only on the author's summary. The sole author cannot provide the
approval required for their own change.

A pull request is mergeable only when required CI passes, approval is current,
all conversations are resolved, and repository-specific gates are satisfied.
Use squash merge.

## Automated assistance

The human submitter remains accountable for correctness, licensing, security,
tests, and provenance. Review generated output before submission and disclose
material automated assistance when it helps reviewers assess risk.

Do not add an automated tool or model as a Git author or co-author. Useful tool
attribution belongs in the pull request description.

## Community standards

Participation is governed by [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md).
