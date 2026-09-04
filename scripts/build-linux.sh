#!/usr/bin/env bash

set -euo pipefail

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
repo_dir="$(cd -- "$script_dir/.." && pwd)"

if ! command -v pacman >/dev/null 2>&1; then
  echo "pacman is required but was not found on PATH." >&2
  exit 1
fi

packages=()
command -v pandoc >/dev/null 2>&1 || packages+=(pandoc-cli)
command -v tectonic >/dev/null 2>&1 || packages+=(tectonic)

if ((${#packages[@]})); then
  pacman_command=(pacman)
  if ((EUID != 0)); then
    if ! command -v sudo >/dev/null 2>&1; then
      echo "Installing packages requires root privileges or sudo." >&2
      exit 1
    fi
    pacman_command=(sudo pacman)
  fi

  echo "Installing missing dependencies: ${packages[*]}"
  "${pacman_command[@]}" -S --needed --noconfirm "${packages[@]}"
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
