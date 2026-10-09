#!/usr/bin/env bash
#
# Deploy the Neovim profiles by symlinking them into the config directory so
# that `NVIM_APPNAME=nvim-<profile> nvim` (and the shared runtimepath entry)
# resolve correctly.
#
# The repository is the source of truth; this script only creates links.
# Existing real directories are backed up, never overwritten.
set -euo pipefail

repo="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
config="${XDG_CONFIG_HOME:-$HOME/.config}"

profiles=(nvim-shared nvim-ide nvim-commit nvim-prose)

mkdir -p "$config"

link() {
  local source="$1" target="$2"
  if [ -e "$target" ] && [ ! -L "$target" ]; then
    local backup="$target.backup.$(date +%Y%m%d%H%M%S)"
    echo "backing up existing $target -> $backup"
    mv "$target" "$backup"
  fi
  ln -sfn "$source" "$target"
  echo "$target -> $source"
}

for name in "${profiles[@]}"; do
  link "$repo/$name" "$config/$name"
done

# Plain `nvim` (NVIM_APPNAME=nvim) opens the IDE profile.
link "$repo/nvim-ide" "$config/nvim"
