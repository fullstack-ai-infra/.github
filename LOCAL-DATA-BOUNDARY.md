# Local Data Boundary

This procedure protects local-only files from being accidentally included in
repository scans or sent to a remote model, CI service, issue, pull request,
or artifact store.

## What is protected

The following must remain outside public repositories and scanner inputs:

- Alibaba internal source, documents, exports, logs, screenshots, and
  credentials;
- `.env` files, private keys, certificates, cloud credentials, and local
  provider configuration;
- browser profiles, chat exports, SSH configuration, and unrelated worktrees;
- generated runtime data, databases, caches, and local agent state.

## Safe local procedure

From the repository that is actually being inspected, run:

```bash
scripts/bytefolk-scrub-env.sh ruby scripts/bytefolk-local-boundary-check.rb .
```

The check is local-only. The wrapper uses an environment allowlist so GitHub,
cloud, package, and model credentials are not inherited by the validator. The
validator uses Git metadata and local `git grep`, prints counts rather than
matching values, and exits non-zero when it finds a sensitive filename, a
tracked credential-shaped value, or a tracked symlink. It does not call a
network service, an LLM, or GitHub.

Use an explicit repository path. Never pass the workspace parent, `$HOME`,
the filesystem root, or a directory containing multiple repositories to a
scanner. In particular, do not run `strix --target .` from the ByteFolk
workspace root.

For a clean, committed-tree-only inspection, first pass the boundary check,
then create a disposable checkout from the exact commit under review. Do not
copy `.env*`, credentials, keys, certificates, runtime state, or unrelated
files into that checkout. A local change that has not been committed should
be reviewed with a local diff or a local scanner; it should not be uploaded to
an external service by default.

## Remote boundary

- A GitHub-hosted job sees repository content only after it is pushed or
  otherwise supplied to the job. It cannot read files sitting on a developer's
  computer.
- Secrets are not safe to expose to arbitrary build, test, or AI steps. Keep
  them in the smallest possible job, and do not place them in command-line
  arguments, logs, artifacts, issue text, or pull-request comments.
- Do not use `pull_request_target` to check out or execute an untrusted pull
  request. Fork pull requests must not receive model-provider or deployment
  credentials.
- If an AI or cloud scanner is used, set its telemetry and data-sharing
  options explicitly, use an approved endpoint, and record the data boundary
  in the validation ledger.
- Do not assume that an environment variable is hidden because it is masked in
  CI logs. A local child process can still inherit it. Run deterministic local
  validators through `scripts/bytefolk-scrub-env.sh`, and never run arbitrary
  repository scripts with a GitHub or provider credential in the environment.

## If exposure is suspected

Stop the scan or upload, preserve only redacted evidence, revoke and rotate
the affected credential, and report the incident privately through the
affected repository's Security tab. Removing a leaked file from the latest
commit is not sufficient.
