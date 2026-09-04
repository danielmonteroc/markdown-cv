#!/usr/bin/env bash

set -euo pipefail

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
else
  echo "Pandoc and Tectonic are already installed."
fi
