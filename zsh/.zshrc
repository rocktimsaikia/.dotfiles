source "$XDG_CONFIG_HOME/zsh/aliases"

# load everything external dependencies
source "$XDG_CONFIG_HOME/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$XDG_CONFIG_HOME/zsh/plugins/bd.zsh"
source "$XDG_CONFIG_HOME/zsh/plugins/zsh-vi-mode/zsh-vi-mode.zsh"
source "$XDG_CONFIG_HOME/zsh/plugins/zsh-autopair/autopair.zsh"
source "$XDG_CONFIG_HOME/zsh/plugins/auto-ls-zsh/auto-ls.zsh"
fpath+="$XDG_CONFIG_HOME/zsh/plugins/pure"

# init prompt and pick pure
autoload -U promptinit; promptinit
zstyle :prompt:pure:git:stash show yes
prompt pure

# load env
source "$XDG_CONFIG_HOME/zsh/plugins/init-nvm.zsh"

# load pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"    # if `pyenv` is not already on PATH
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

# the syntax highlighting plugins requires to be sourced at the end
source "$XDG_CONFIG_HOME/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
