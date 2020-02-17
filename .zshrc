if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
autoload -Uz compinit
if [[ -n ~/.zcompdump(#qN.mh+24) ]]; then
  compinit
  touch .zcompdump
else
  compinit -C
fi
export PATH=$HOME/work/bin:$PATH
export GPG_TTY=$(tty)
export PATH=$HOME/.local/bin:$PATH
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="powerlevel10k/powerlevel10k"
POWERLEVEL9K_MODE="awesome-patched"
plugins=(git)
source $ZSH/oh-my-zsh.sh
if [ -f ~/.bash_aliases ]; then
        . ~/.bash_aliases
fi
source "/home/ajoian/work/bin/z.sh"
autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit
source /etc/bash_completion.d/az.completion
source /etc/bash_completion.d/azure-cli
eval $(keychain --eval id_rsa --quiet)
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
