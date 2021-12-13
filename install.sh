#!/bin/bash

# init nvim config (create and symlink)
mkdir -p "$HOME/.config/nvim"
ln -sf "$HOME/.dotfiles/nvim/init.vim" "$HOME/.config/nvim"

# init zsh config
mkdir -p "$HOME/.config/zsh"
ln -sf "$HOME/.dotfiles/zsh/.zshenv" "$HOME"
ln -sf "$HOME/.dotfiles/zsh/.zshrc" "$HOME/.config/zsh"
