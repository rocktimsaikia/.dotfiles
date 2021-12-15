source "$XDG_CONFIG_HOME/zsh/aliases"

# load everything external dependencies
source "$XDG_CONFIG_HOME/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$XDG_CONFIG_HOME/zsh/plugins/bd.zsh"
source "$XDG_CONFIG_HOME/zsh/plugins/zsh-vi-mode/zsh-vi-mode.zsh"
source "$XDG_CONFIG_HOME/zsh/plugins/zsh-autopair/autopair.zsh"
fpath+="$XDG_CONFIG_HOME/zsh/plugins/pure"

# init prompt and pick pure
autoload -U promptinit; promptinit
zstyle :prompt:pure:git:stash show yes
prompt pure

# the syntax highlighting plugins requires to be sourced at the end
source "$XDG_CONFIG_HOME/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
