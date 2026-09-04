#!/usr/bin/env bash

set -euo pipefail

if ! command -v brew >/dev/null 2>&1; then
  echo "Homebrew is required but was not found on PATH." >&2
  exit 1
fi

packages=()
command -v pandoc >/dev/null 2>&1 || packages+=(pandoc)
command -v tectonic >/dev/null 2>&1 || packages+=(tectonic)
font_cask=font-ubuntu-nerd-font

if ((${#packages[@]})); then
  echo "Installing missing dependencies: ${packages[*]}"
  brew install "${packages[@]}"
fi

if ! brew list --cask "$font_cask" >/dev/null 2>&1; then
  echo "Installing Ubuntu Nerd Font"
  brew install --cask "$font_cask"
fi

echo "Pandoc, Tectonic, and Ubuntu Nerd Font are available."
