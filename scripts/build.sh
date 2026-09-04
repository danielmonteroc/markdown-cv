#!/usr/bin/env sh

set -eu

script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
repo_dir=$(CDPATH= cd -- "$script_dir/.." && pwd)

for dependency in pandoc tectonic; do
  if ! command -v "$dependency" >/dev/null 2>&1; then
    echo "$dependency is required. Run the dependency installer for your platform first." >&2
    exit 1
  fi
done

cd "$repo_dir"
SOURCE_DATE_EPOCH=${SOURCE_DATE_EPOCH:-0}
FORCE_SOURCE_DATE=${FORCE_SOURCE_DATE:-1}
export SOURCE_DATE_EPOCH FORCE_SOURCE_DATE

pandoc --defaults pandoc.yaml
echo "Created $repo_dir/resume.pdf"
