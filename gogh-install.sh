#!/bin/bash

# This is only if you use Ubuntu gnome terminal
# Checks if gogh is already added. If not set it up and install a theme
# Sets tokyonight theme by default
if [ ! -d "$HOME/src/gogh" ]; then
    mkdir -p "$HOME/src"
    git clone https://github.com/Mayccoll/Gogh.git "$HOME/src/gogh"
    export terminal=gnome-terminal
    #install tokyonight theme
    bash "$HOME/src/gogh/tokyo-night.sh"
