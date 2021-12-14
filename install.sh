#!/bin/bash

# init nvim config (create and symlink)
mkdir -p "$HOME/.config/nvim"
ln -sf "$HOME/.dotfiles/nvim/init.vim" "$HOME/.config/nvim"

# init zsh config
mkdir -p "$HOME/.config/zsh"
ln -sf "$HOME/.dotfiles/zsh/.zshenv" "$HOME"
ln -sf "$HOME/.dotfiles/zsh/.zshrc" "$HOME/.config/zsh"
ln -sf "$HOME/.dotfiles/zsh/aliases" "$HOME/.config/zsh"

# set up external dependencies
# check and install Pure, a minimal prompt
PROMPT_PURE_DIR="$HOME/.dotfiles/zsh/plugins/pure"
if [ ! -d "$PROMPT_PURE_DIR" ]; then
    git clone https://github.com/sindresorhus/pure.git "$PROMPT_PURE_DIR"
fi

ln -sf "$HOME/.dotfiles/zsh/plugins" "$HOME/.config/zsh"
