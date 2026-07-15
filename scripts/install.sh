#!/usr/bin/env bash
# Install DiagStack Cursor skills (dsc-a, dsc-b) to ~/.cursor/skills/
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
TARGET_ROOT="${HOME}/.cursor/skills"

mkdir -p "${TARGET_ROOT}"

install_skill() {
  local name="$1"
  local src="${REPO_ROOT}/skills/${name}"
  local dst="${TARGET_ROOT}/${name}"
  if [[ ! -d "${src}" ]]; then
    echo "Skill source not found: ${src}" >&2
    exit 1
  fi
  rm -rf "${dst}"
  cp -R "${src}" "${dst}"
  echo "Installed: ${dst}"
}

install_skill "dsc-a"
install_skill "dsc-b"

# Remove legacy long name if present
rm -rf "${TARGET_ROOT}/diagstack-c-comment-style"

echo "Restart Cursor or start a new chat."
echo "Call short names: dsc-a (comments only) | dsc-b (comments + MISRA)"
