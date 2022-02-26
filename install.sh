#!/bin/bash

# init nvim config (create and symlink)
mkdir -p "$HOME/.config/nvim"
ln -sf "$HOME/.dotfiles/nvim/init.vim" "$HOME/.config/nvim"
ln -sf "$HOME/.dotfiles/nvim/coc-settings.json" "$HOME/.config/nvim"
ln -sf "$HOME/.dotfiles/nvim/after" "$HOME/.config/nvim"

# init zsh config
mkdir -p "$HOME/.config/zsh"
ln -sf "$HOME/.dotfiles/zsh/.zshenv" "$HOME"
ln -sf "$HOME/.dotfiles/zsh/.zshrc" "$HOME/.config/zsh"
ln -sf "$HOME/.dotfiles/zsh/aliases" "$HOME/.config/zsh"

# symlink the external submodules
ln -sf "$HOME/.dotfiles/zsh/plugins" "$HOME/.config/zsh"
