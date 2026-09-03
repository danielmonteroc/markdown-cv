#!/usr/bin/env bash

set -euo pipefail

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
repo_dir="$(cd -- "$script_dir/.." && pwd)"
invocation_dir="$PWD"

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

input_path="${1:-$repo_dir/resume.md}"
if [[ "$input_path" != /* ]]; then
  input_path="$invocation_dir/$input_path"
fi

if [[ ! -f "$input_path" ]]; then
  echo "Markdown input not found: $input_path" >&2
  exit 1
fi

if (($# >= 2)); then
  output_path="$2"
  if [[ "$output_path" != /* ]]; then
    output_path="$invocation_dir/$output_path"
  fi
else
  output_path="${input_path%.*}.pdf"
fi

cd "$repo_dir"
export SOURCE_DATE_EPOCH="${SOURCE_DATE_EPOCH:-0}"
export FORCE_SOURCE_DATE="${FORCE_SOURCE_DATE:-1}"
pandoc --defaults pandoc.yaml "$input_path" --output "$output_path"
echo "Created $output_path"
