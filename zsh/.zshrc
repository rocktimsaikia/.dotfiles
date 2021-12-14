source "$XDG_CONFIG_HOME/zsh/aliases"

# load everything external dependencies
source "$XDG_CONFIG_HOME/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
fpath+="$XDG_CONFIG_HOME/zsh/plugins/pure"

# init prompt and pick pure
autoload -U promptinit; promptinit
zstyle :prompt:pure:git:stash show yes
prompt pure
