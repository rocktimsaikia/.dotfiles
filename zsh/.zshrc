# init prompt and pick pure
fpath+="$XDG_CONFIG_HOME/zsh/pure"
autoload -U promptinit; promptinit
zstyle :prompt:pure:git:stash show yes
prompt pure

source "$XDG_CONFIG_HOME/zsh/aliases"
source "$XDG_CONFIG_HOME/zsh/antigen.zsh"

bindkey -e
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle MichaelAquilina/zsh-you-should-use
antigen bundle hlissner/zsh-autopair

#zsh-you-should-use
export YSU_MESSAGE_POSITION="after"

#zsh-autosuggestions
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

#load nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

antigen apply
