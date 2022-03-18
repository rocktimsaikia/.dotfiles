#!/bin/bash

# init nvim config (create and symlink)
mkdir -p "$HOME/.config/nvim"
ln -sf "$HOME/.dotfiles/nvim/init.vim" "$HOME/.config/nvim"
ln -sf "$HOME/.dotfiles/nvim/coc-settings.json" "$HOME/.config/nvim"
ln -sf "$HOME/.dotfiles/nvim/after" "$HOME/.config/nvim"

# init zsh config
mkdir -p "$HOME/.config/zsh"
ln -sf "$HOME/.dotfiles/zsh/.zshenv" "$HOME"
ln -sf "$HOME/.dotfiles/zsh" "$HOME/.config/zsh"
ln -sf "$HOME/.dotfiles/zsh/aliases" "$HOME/.config/zsh"
ln -sf "$HOME/.dotfiles/zsh/antigen.zsh" "$HOME/.config/zsh"
ln -sf "$HOME/.dotfiles/zsh/pure" "$HOME/.config/zsh"

# symlink tmux conf file
ln -sf "$HOME/.dotfiles/tmux/.tmux.conf" "$HOME/.tmux.conf"
