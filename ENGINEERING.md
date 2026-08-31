# Engineering Standards

This document is the operational layer of the organization baseline. It
defines the practices `fullstack-ai-infra` repositories adopt: language and
attribution policy, branch and commit rules, mandatory testing, issue
governance, pull request gates, and code review rules.

It complements [`CONTRIBUTING.md`](CONTRIBUTING.md) and
[`GOVERNANCE.md`](GOVERNANCE.md). When this document and a repository-local
policy conflict, the repository-local policy wins for that repository;
repository policy may strengthen this baseline. A weaker policy requires the
recorded organization-governance exception defined in `GOVERNANCE.md`.

Release procedures live in [`RELEASING.md`](RELEASING.md).

Publishing this baseline does not silently change repository settings or
erase repository-local policy. An existing repository records any adoption
gap and rollout in its own governance or delivery issue before claiming the
corresponding control is enforced.

## Language and attribution policy

- **English is canonical.** Issues, pull requests, commit messages, code
  comments, canonical documentation, release notes, and repository and package
  descriptions are written in English. Explicit translations are permitted
  when they are clearly identified (for example, `README.zh-CN.md`), link back
  to the English canonical document, and are kept semantically synchronized.
  Conversation outside the repository may use any language.
- **No automated co-authors.** Commits must not carry `Co-Authored-By`
  trailers or author entries for AI agents, models, or automation tools, and
  such tools must not be credited as authors anywhere in Git metadata.
  Attribution for useful tooling, when worth recording, belongs in the pull
  request description, in line with
  [`CONTRIBUTING.md`](CONTRIBUTING.md#automated-assistance).
- The human submitter remains accountable for correctness, licensing,
  security, tests, and provenance of everything submitted.

## Development

### Branches

- Branch from the latest default branch (`main`). Never develop directly on a
  protected branch.
- Name branches `<type>/<issue-number>-<short-description>` with type in
  `feat`, `fix`, `docs`, `refactor`, `test`, `chore`, `ci`.
- One branch per issue. Keep unrelated changes out.
- An ordinary, fast-forward push is the default. Do not rewrite shared history.
  A maintainer may explicitly authorize a rewrite only for a branch controlled
  by its author, and the authorization must name the branch and expected remote
  head.
  Before using `--force-with-lease`, verify the pull request's head repository,
  full `refs/heads/...` ref, and head SHA; fetch that exact ref from the explicit
  remote; and compare the fetched commit with the expected SHA. Push to that
  remote and full ref with
  `--force-with-lease=refs/heads/<branch>:<expected-sha>`. Never infer the
  remote from a branch name or rewrite somebody else's branch. A rewritten
  head invalidates prior approvals and CI evidence.

### Commits

- Follow Conventional Commits:
  `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `build`,
  `ci`, `chore`, `revert`.
- The commit message body references the tracking issue (`#N`) and, when the
  work consumes a requirement revision, that revision (for example `R2`).
- Keep commits reviewable and scoped. Merges use squash; the squash commit is
  the release baseline.

### Testing requirements (mandatory, no exemptions)

- **Work is not complete until it is tested.** Before requesting review, run
  every check the repository documents: formatting, linting, type checks,
  build, tests, and security checks. Where a Node repository declares the
  organization's unified gate, it is `npm run check` (`typecheck` → `build` →
  `test` → `governance:check` → `security:check`); otherwise run that repository's
  documented command set. A broken applicable chain means the change is
  unfinished; do not open a pull request.
- New functionality ships with tests. Bug fixes ship with a regression test,
  or the pull request explains why one is impractical.
- Known environment-specific failures (for example, a test that fails only on
  a specific platform) are recorded in the pull request's validation ledger
  with the reason and the CI result that covers them. They are never skipped
  silently, and test output is never fabricated.
- Documentation-only and typo changes may omit new tests but must still pass
  the existing CI.
- Evidence over assertion: test output, coverage, benchmark data, and review
  records must be real and reproducible. Fabricating evidence is a governance
  red line.

### Security and dependencies

- Never commit secrets, personal data, or generated caches.
  `security:check` must pass where the repository provides it.
- Vulnerabilities are reported privately per [`SECURITY.md`](SECURITY.md),
  never through public issues.
- Dependency changes go through Dependabot or a dedicated issue. Do not
  upgrade unrelated dependencies inside a feature branch.

## Issues

### General rules

- **The issue is the single entry point for work.** A repository's first
  milestone is its first issue, with acceptance criteria that include
  on-machine verification items. Later milestones each get their own issue.
- An issue is **ready** only after a maintainer confirms scope, acceptance
  criteria, dependencies, and the validation approach. Implementation starts
  after ready, not before.
- Security problems are never filed as public issues.

### Requirement-record governance (one issue, one implementation revision)

- Each implementation revision maps to exactly one issue. After a revision is
  consumed by a merged pull request, new work opens a **new child issue** to
  receive a new revision. Do not reopen a closed issue to stack another
  revision onto it; additive version bumps apply only to design and
  governance revisions.
- Issue bodies carry: the `DEC-<REPO>-<number>-001` decision marker with a
  timestamp, a revision history, and — where the repository's governance
  requires it — `REQ-\d{3}` / `AC-\d{3}` identifiers.
- Creation flow: draft the body with `__TS__` / `__NUM__` placeholders,
  create with `gh issue create --body-file`, then backfill the DEC marker and
  timestamp with `gh issue edit`, then re-fetch and verify the markers are
  present and no placeholders remain.
- Retrofitting governance onto an unrecorded issue: post a
  `requirement-decision:v1` decision comment first, then bump the body
  version (formalize only, never change meaning), then fix labels, then
  re-fetch and verify.
- A requirement-record issue and a delivery issue may be separate objects
  (one records the requirement, one tracks the work). When closing or posting
  evidence, cross-check both and state their relationship in a comment to
  avoid duplicate or missed closures.

### Labels and milestones

- Use existing labels only. **Creating a label requires approval**; never
  create one unilaterally. If a needed label does not exist, proceed with a
  degraded classification and note it in the body.
- Milestone `due_on` is stored in UTC. For a target date in UTC+8, set
  `07:00Z` on that date (`00:00Z` displays one day early due to timezone).
  Read the value back after `PATCH` to verify.

### Closing flow

1. Product review posts an ACCEPT comment.
2. If the work was split, the child issue establishes the new anchor.
3. Post the `requirement-decision:v1` closing decision comment.
4. Bump the body version (`status=accepted`, DEC marker, revision history).
5. Close with `gh issue close --reason completed`.

- Reopening a closed ledger issue is forbidden; follow-ups are append-only
  comments, and the body carries all cross-references.
- Long evidence comments go through `gh issue comment N --body-file` before
  closing (`gh issue close` has no `--comment-file`, and `--comment` on an
  already-closed issue does not post).

## Pull requests

### Before submitting

- The tracking issue is ready (§Issues) and the branch follows the naming
  rule above.
- Size: the smallest complete change. Prefer ≤ 400 lines of diff per pull
  request; larger ones must be split or justified in the summary.
- The local gate (§Testing requirements) is fully green.

### Title and body

- Title: Conventional Commits style plus `(#issue-number)`, at most 70
  characters.
- Body: use the repository's template. Repositories with governance gates
  (the `digital-employee` repository is the reference implementation)
  additionally require:
  - the template's section headings kept verbatim, none removed;
  - `Consumed revision` written exactly as `R<positive integer>` with no
    leading zero, parentheses, or extra text;
  - every trace row's first cell containing both `REQ-\d{3}` and `AC-\d{3}`;
  - `Observed counts` containing PASS/FAIL terms plus `N/N`;
  - `packet`: a GitHub URL or `N/A: <reason>`;
  - validation ledger rows with IDs `V<integer>` and status restricted to
    `PASS`, `FAIL`, `NOT VERIFIED`, or `N/A`.
- Self-check locally before pushing the body:
  `npm run governance:precheck -- --body-file <pr-body.md>`.

### CI and evidence

- Green CI is a merge precondition. Diagnose failures with
  `gh run view <run-id> --log-failed` and distinguish real test failures from
  governance-gate (`--github-event-file`) failures.
- **Editing a PR body does not retrigger CI.** A stale governance gate that
  failed on an old event snapshot only clears with a new push.
- Validation evidence (output excerpts, CI job URLs, screenshots, test
  paths) must be real and reproducible. A check that cannot run locally must
  state why and which CI result covers it.

### Merge

- Merge requires: independent approval of the exact current head commit
  (§Code review), required CODEOWNER approval where `CODEOWNERS` applies, all
  conversations resolved, green required checks for that same commit, and all
  repository gates satisfied. Read the pull request head SHA immediately
  before merging and use an exact-head guard when the merge tool supports one.
- Always **squash merge**; tags and releases are anchored on the squash
  commit. Delete the branch after merge.
- Never use an administrator bypass to merge ordinary work. Missing approval,
  CODEOWNER coverage, checks, or protection configuration is a blocker to fix,
  not permission to use an admin merge.
- For a fork pull request, read its head repository, full head ref, and head
  SHA from GitHub. Pushing to a same-named organization branch will not update
  it. Use an explicit remote for the fork and an ordinary push when it is a
  fast-forward. The narrowly authorized lease procedure in §Branches is the
  only permitted non-fast-forward path. After any push, wait until GitHub
  reports the expected new head SHA before accepting CI or review evidence.

## Code review

### Principles

- **Independent review.** The sole author cannot approve their own change. A
  single-maintainer repository asks the organization owner or another
  qualified maintainer to review; a missing second reviewer is a staffing
  blocker, never permission to self-approve.
- **Evidence over assertion.** Reviewers independently verify the material
  claims in the pull request rather than trusting the author's summary.
- Review the change, not the author.

### Process and timing

- First response target: within 24 hours; a full review round within 72
  hours. Maintainers may adjust and publish repository-specific targets.
- Draft pull requests are welcome for early feedback but are not mergeable.
- Approval is valid only for the exact pull request head commit that the
  reviewer examined. Every later push makes that approval stale and requires a
  new approval after the new head's required checks pass. Branch protection
  must dismiss stale approvals and require approval of the most recent
  reviewable push where GitHub supports those controls.
- A required CODEOWNER approval must come from an eligible owner other than
  the sole author. Administrators and organization owners follow the same
  review and exact-head requirements; they do not bypass them for ordinary
  work.

### Comment severity

| Severity | Meaning | Merge impact |
| --- | --- | --- |
| Blocker | Correctness, security, or governance red line | Must fix and re-review |
| Major | Clear defect, insufficient tests, acceptance criteria unmet | Must fix in this round |
| Minor | Improvement worth making | Fix or justify deferral, then merge |
| Nit | Non-blocking suggestion | Never blocks; author's choice |

### Review focus, in order

1. Correctness and the mapping to acceptance criteria.
2. Test sufficiency: new behavior tested, regressions reproduced.
3. Security and privacy: secrets, injection, permissions, personal data.
4. Readability and maintainability.
5. Documentation and changelog synchronization.

Style is enforced by linters and formatters, not by reviewers.

### Author duties

- Respond to every comment. After fixing, reply with what changed; resolve
  the conversation only when the fix is confirmed.
- When disagreeing with a review comment, argue with evidence and the written
  standards; the maintainer decides and records the decision.

## Changing this document

Changes follow the same flow as everything else:
[Issue → branch → pull request → CI → independent review → squash](CONTRIBUTING.md).
