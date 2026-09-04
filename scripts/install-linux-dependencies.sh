#!/usr/bin/env bash

set -euo pipefail

if ! command -v pacman >/dev/null 2>&1; then
  echo "pacman is required but was not found on PATH." >&2
  exit 1
fi

packages=()
command -v pandoc >/dev/null 2>&1 || packages+=(pandoc-cli)
command -v tectonic >/dev/null 2>&1 || packages+=(tectonic)
pacman -Qq ttf-ubuntu-nerd >/dev/null 2>&1 || packages+=(ttf-ubuntu-nerd)

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
else
  echo "Pandoc, Tectonic, and Ubuntu Nerd Font are already installed."
fi
