# Release Process

This document defines the release baseline for `bytefolk`
repositories. A repository may add stricter automation, but it may not skip an
applicable gate. Each repository declares which distribution channels it
supports; npm, GitHub Release, and GHCR are checked explicitly, but a repository
is not required to publish to a channel it does not support.

## Versioning

- Use Semantic Versioning 2.0.0: `MAJOR.MINOR.PATCH`.
- For a stable public API at version `1.0.0` or later, an incompatible change
  requires the next `MAJOR` version. A prerelease identifier does not reduce
  that requirement: previewing the change uses that next major line (for
  example, `2.0.0-alpha.1`), not a `1.x` prerelease.
- While the public API is below `1.0.0`, an incompatible change may use the
  next `MINOR` version, but the instability and each breaking change must be
  called out explicitly in the release record and release notes.
- One release issue selects one version. A failed or incorrect publication is
  corrected with a new version; a published package version or tag is never
  reused.

## Release record and declared channels

The release issue is the append-only control record. Before implementation it
records revision `R1`, a DEC marker, the version, candidate `main` baseline,
rollback criteria, and a channel matrix with one row for each of these
organization-known channels. After the release pull request merges, append its
exact full squash commit and exact-commit check evidence:

| Channel | Required declaration |
| --- | --- |
| npm | Exact package name and dist-tag, or `N/A: <evidence-based reason>` |
| GitHub Release | Expected asset inventory, or `N/A: <evidence-based reason>` |
| GHCR | Exact image name and tag/digest policy, or `N/A: <evidence-based reason>` |

`N/A` is valid only when the repository does not declare that channel for the
release. The reason and the repository policy or product decision supporting it
must be reviewable. A missing artifact on a declared channel is a failure, not
`N/A`.

## Release flow

Every release follows these six ordered phases. The `mem` release workflow is
the safety precedent for an asset-backed npm package: merge the reviewed
release machinery first, consume an existing immutable tag, publish assets as
a verified draft, and only then publish the dependent npm package.

1. **Release issue.** Create a dedicated release issue through the standard
   issue flow (placeholders backfilled and verified; see
   [`ENGINEERING.md`](ENGINEERING.md#requirement-record-governance-one-issue-one-implementation-revision)).
   Approve its version, declared-channel matrix, risk, and rollback plan.
2. **Release preparation pull request.** Move the applicable changelog or
   versioned release-ledger entries out of `Unreleased`, synchronize every
   public version surface, and add or harden the release workflow in this same
   pull request. Run all repository gates. A required CODEOWNER independently
   approves the exact final head, and the pull request is squash-merged through
   protected `main` without an administrator bypass. Versioned release content
   is therefore on `main` before a tag exists; do not add a second, post-tag
   ledger pull request to redefine what the release contained.
3. **Pre-tag gate and immutable tag.** Record the release pull request's full
   squash commit and the successful required checks for that exact commit.
   Fetch `origin/main`, prove the selected commit resolves exactly and is
   reachable from `origin/main`, prove the version is unused on every declared
   channel, and read back the release-tag rulesets. Only after all of those
   checks pass may the least-privileged authorized release actor create and
   push the tag once, as described in §Immutable tag gate.
4. **Release workflow.** The tagged commit contains a reviewed workflow already
   merged on `main`. That workflow consumes the existing annotated tag; it
   never creates, moves, or replaces one. It resolves the full tag ref, rejects
   a lightweight or non-`main` tag and any version mismatch, and builds from
   the exact peeled commit in a clean hosted environment. Where GitHub Release
   is declared, upload to a draft, read back the exact non-empty asset inventory
   and checksums, and make publication the final step. A manual retry names the
   same existing tag and re-runs every source check; any workflow change used
   for a retry first needs its own issue, pull request, checks, and independent
   review. A retry is never permission to create or repair a tag.
5. **Publish and verify declared channels.** Follow dependency order. For
   example, an npm installer that downloads GitHub Release assets publishes
   only after those assets and their checksums have been verified. Read every
   declared channel back independently using §Channel evidence. Record an
   evidence-backed `N/A` for each intentionally unsupported channel.
6. **Close the release record.** Append exact URLs, commits, digests,
   integrity values, signature/provenance results, workflow runs, smoke tests,
   and every approved `N/A` to the release issue. Close it only when all
   applicable rows pass. This post-publication receipt is evidence about the
   already versioned release, not a new code ledger that can change it.

## Immutable tag gate

Release `v*` tags must be protected by server-side rulesets before the first
release under this baseline:

- an active immutable-tag rule for `refs/tags/v*` prohibits update and deletion
  with no bypass path; and
- a separate creation rule restricts new `refs/tags/v*` tags, with bypass only
  for the minimum repository role or release identity that must create one.

Read both rulesets back and attach their identifiers, active enforcement,
`refs/tags/v*` conditions, creation/update/deletion rules, and bypass actors to
the release issue. Broad write access, a local hook, and a documented promise
are not tag protection. Use the least-privileged eligible actor for the single
creation; administrative access is not a reason to bypass an unmet release
gate.

### Adoption by repositories with existing releases

A repository that published releases before adopting this baseline records
its current tag protections and any gap in a dedicated adoption or release
issue. It must install and read back both required rulesets before its next
release after adoption. Until that evidence is recorded, the repository may
prepare reviewed release changes but must not create a new release tag or
publish another version. Existing tags are not rewritten or deleted during
adoption.

The ancestry and absence checks happen **before** `git tag`. Use a clean
checkout and substitute the full squash commit SHA and version below:

```bash
set -euo pipefail
version="${RELEASE_VERSION:?set RELEASE_VERSION to vX.Y.Z}"
release_commit="${RELEASE_COMMIT:?set RELEASE_COMMIT to the full squash SHA}"

git fetch --prune --no-tags origin \
  refs/heads/main:refs/remotes/origin/main
resolved_commit="$(git rev-parse --verify "${release_commit}^{commit}")"
test "${resolved_commit}" = "${release_commit}"
test "$(git rev-parse HEAD)" = "${release_commit}"
test -z "$(git status --porcelain)"
git merge-base --is-ancestor \
  "${release_commit}" refs/remotes/origin/main
test -z "$(git tag --list "${version}")"
test -z "$(git ls-remote --tags origin \
  "refs/tags/${version}" "refs/tags/${version}^{}")"

# Confirm the GitHub Release and every declared registry version are also
# absent here. Only then create the first and only tag for this version.
git tag -a "${version}" "${release_commit}" -m "Release ${version}"
test "$(git rev-parse "${version}^{commit}")" = "${release_commit}"
git push origin "refs/tags/${version}:refs/tags/${version}"

remote_commit="$(git ls-remote --tags origin \
  "refs/tags/${version}^{}" | awk '{print $1}')"
test "${remote_commit}" = "${release_commit}"
```

The peeled `^{}` lookup proves the remote tag is annotated and points to the
recorded commit. If a tag push has an ambiguous result, read the remote ref
before retrying. Never delete, force-push, move, or recreate a stable tag; fix
a bad release with a new issue and new PATCH version.

## Channel evidence

### GitHub Release

- Read back the tag name, target commit, draft/prerelease state, release URL,
  and exact asset names and non-zero sizes.
- Download assets into a fresh directory and verify the repository-declared
  checksums or signatures. Where binaries embed source metadata, verify the
  recorded VCS revision is the release commit and the tree is unmodified.

### npm

Trusted Publishing with GitHub Actions OIDC is the normal npm credential path.
Pin the publisher to the exact organization, repository, workflow filename,
and environment when one is used, and set npm's **Allowed actions** to
`npm publish` only. The independently reviewed workflow grants only the
permissions it needs, including `id-token: write`, and publishes with
provenance. Do not keep a long-lived npm token in repository, organization,
runner, or maintainer configuration.

An initial publication may require bootstrap authentication before npm lets the
package configure a Trusted Publisher. That exception requires release-issue
authorization. Prefer an interactive web login whose generated local session
is isolated to a temporary user-config file and revoked immediately. If npm
instead requires a granular token, restrict it to the single intended package
(or the narrowest npm scope capable of creating that package), grant package
read/write only, and select the shortest available expiry. Never place any
credential in a repository file, command argument, workflow input, log, or
issue comment. Publish once, complete registry and clean-consumer verification,
and log out or revoke the bootstrap credential immediately. Configure the
Trusted Publisher next, then land the OIDC workflow as a separate independently
reviewed pull request; only a later real OIDC publication proves that
configuration works.

`npm view` reads registry metadata; it does **not** verify a signature or
provenance attestation. Record and compare the exact package source, version,
Git commit, and registry integrity, then verify signatures/attestations from a
clean install with a supported, pinned npm version:

```bash
package=@scope/name
version=X.Y.Z
npm_cli_version="${NPM_CLI_VERSION:?pin an approved npm CLI version}"
npm_cli=(npx --yes "npm@${npm_cli_version}")

"${npm_cli[@]}" view "${package}@${version}" \
  name version repository.url gitHead dist.integrity --json
consumer="$(mktemp -d)"
cd "${consumer}"
"${npm_cli[@]}" init --yes >/dev/null
"${npm_cli[@]}" install --ignore-scripts --save-exact "${package}@${version}"
"${npm_cli[@]}" ls "${package}" --depth=0
"${npm_cli[@]}" audit signatures
```

The installed version and lockfile integrity must equal the registry readback,
the repository URL and `gitHead` must identify the expected source and release
commit, and `npm audit signatures` must succeed. Then run the
repository-defined first-use smoke test in that clean consumer; disabling
lifecycle scripts for installation must not silently replace that test.

### GHCR

- Read the manifest by the declared version tag and record its immutable
  digest and platform inventory.
- Pull and smoke-test by digest. Evidence for a mutable tag without its digest
  is insufficient.

## Changelog, rollback, and red lines

- Changelogs are organized from Conventional Commits, grouped by `feat`,
  `fix`, and breaking changes. The versioned entry merges before tagging.
- Every release pull request's risk section states an executable rollback
  procedure. Rollback never reuses or moves a published tag or package
  version.
- Never declare a release successful before every applicable channel has been
  read back and every `N/A` has an approved, evidence-based reason.
- Never use an administrator merge or protection bypass to compensate for a
  missing check, approval, CODEOWNER, ruleset, credential design, or release
  artifact.
- Release write operations (issue creation, tag push, and publication) are
  drafted and reviewed before execution, like any other governed change.
- Release commits must not carry automated-tool co-author trailers, per
  [`ENGINEERING.md`](ENGINEERING.md#language-and-attribution-policy).
