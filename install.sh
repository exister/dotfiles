#!/usr/bin/env bash

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "Installing dotfiles from $DOTFILES_DIR"

backup() {
  local target="$1"

  if [ -e "$target" ] && [ ! -L "$target" ]; then
    local backup="${target}.backup.$(date +%s)"
    echo "Backing up $target → $backup"
    mv "$target" "$backup"
  fi
}

link() {
  local src="$1"
  local dest="$2"

  backup "$dest"

  if [ -L "$dest" ]; then
    rm "$dest"
  fi

  echo "Linking $dest → $src"
  ln -s "$src" "$dest"
}

mkdir -p "$HOME/.config"

# ZSH
link "$DOTFILES_DIR/zsh/.zshenv" "$HOME/.zshenv"
link "$DOTFILES_DIR/zsh/.zprofile" "$HOME/.zprofile"
link "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"

# CONFIG DIRS
link "$DOTFILES_DIR/config/shell" "$HOME/.config/shell"
link "$DOTFILES_DIR/config/direnv" "$HOME/.config/direnv"

# FILE CONFIGS
link "$DOTFILES_DIR/config/starship.toml" "$HOME/.config/starship.toml"

echo "Done."
