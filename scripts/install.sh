#!/usr/bin/env bash
# Install DiagStack Cursor skills to ~/.cursor/skills/
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SKILL_SRC="${REPO_ROOT}/skills/diagstack-c-comment-style"
TARGET_ROOT="${HOME}/.cursor/skills"
SKILL_DST="${TARGET_ROOT}/diagstack-c-comment-style"

if [[ ! -d "${SKILL_SRC}" ]]; then
  echo "Skill source not found: ${SKILL_SRC}" >&2
  exit 1
fi

mkdir -p "${TARGET_ROOT}"
rm -rf "${SKILL_DST}"
cp -R "${SKILL_SRC}" "${SKILL_DST}"

echo "Installed: ${SKILL_DST}"
echo "Restart Cursor or start a new chat to use diagstack-c-comment-style."
