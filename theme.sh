#!/bin/bash

# Color Scheme for Gnome Terminal
# theme: tokyonight
if [ ! -d "$HOME/src/gogh" ]; then
    mkdir -p "$HOME/src"
    git clone https://github.com/Mayccoll/Gogh.git "$HOME/src/gogh"
    export terminal=gnome-terminal
    #install tokyonight theme
    bash "$HOME/src/gogh/tokyo-night.sh"
