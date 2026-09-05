#!/usr/bin/env bash

set -euo pipefail

if [[ "$#" -eq 0 ]]; then
  echo "usage: scripts/bytefolk-scrub-env.sh COMMAND [ARG ...]" >&2
  exit 2
fi

# Use an allowlist instead of trying to guess every provider-specific secret
# variable. This wrapper is for local scanners and validators that do not need
# credentials. It does not grant filesystem isolation; keep the command inside
# one explicit repository and run the boundary check first.
safe_path="${PATH:-/usr/bin:/bin:/usr/sbin:/sbin}"
safe_lang="${LANG:-C}"
safe_lc_all="${LC_ALL:-C}"
safe_tmpdir="${TMPDIR:-/tmp}"

exec env -i \
  PATH="$safe_path" \
  LANG="$safe_lang" \
  LC_ALL="$safe_lc_all" \
  TMPDIR="$safe_tmpdir" \
  GIT_TERMINAL_PROMPT=0 \
  "$@"
