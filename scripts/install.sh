#!/usr/bin/env bash
# Install all Cursor skills from this repo to ~/.cursor/skills/
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SKILLS_SRC="${REPO_ROOT}/skills"
TARGET_ROOT="${HOME}/.cursor/skills"

if [[ ! -d "${SKILLS_SRC}" ]]; then
  echo "Skills source not found: ${SKILLS_SRC}" >&2
  exit 1
fi

mkdir -p "${TARGET_ROOT}"

installed=()
for skill_dir in "${SKILLS_SRC}"/*/; do
  skill_name="$(basename "${skill_dir}")"
  skill_dst="${TARGET_ROOT}/${skill_name}"
  rm -rf "${skill_dst}"
  cp -R "${skill_dir}" "${skill_dst}"
  installed+=("${skill_name}")
done

echo "Installed skills to ${TARGET_ROOT}:"
for name in "${installed[@]}"; do
  echo "  - ${name}"
done
echo "Restart Cursor or start a new chat to use installed skills."
