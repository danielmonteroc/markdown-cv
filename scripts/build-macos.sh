#!/usr/bin/env bash

set -euo pipefail

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
repo_dir="$(cd -- "$script_dir/.." && pwd)"

if ! command -v brew >/dev/null 2>&1; then
  echo "Homebrew is required but was not found on PATH." >&2
  exit 1
fi

packages=()
command -v pandoc >/dev/null 2>&1 || packages+=(pandoc)
command -v tectonic >/dev/null 2>&1 || packages+=(tectonic)

if ((${#packages[@]})); then
  echo "Installing missing dependencies: ${packages[*]}"
  brew install "${packages[@]}"
fi

if [[ ! -f "$repo_dir/resume.md" ]]; then
  echo "Markdown input not found: $repo_dir/resume.md" >&2
  exit 1
fi

cd "$repo_dir"
export SOURCE_DATE_EPOCH="${SOURCE_DATE_EPOCH:-0}"
export FORCE_SOURCE_DATE="${FORCE_SOURCE_DATE:-1}"
pandoc --defaults pandoc.yaml
echo "Created $repo_dir/resume.pdf"
