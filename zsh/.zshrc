source "$XDG_CONFIG_HOME/zsh/aliases"

# load everything external dependencies
fpath+="$XDG_CONFIG_HOME/zsh/plugins/pure"

# init prompt and pick pure
autoload -U promptinit; promptinit
zstyle :prompt:pure:git:stash show yes
prompt pure
