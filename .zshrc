#
# ~/.zshrc
#

alias assume="source assume"

# Change the window title of X terminals
use_color=true

alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias more=less

# Zsh history options (replaces shopt -s histappend)
setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS

# la = ls -la
alias ls="ls --color=auto"
alias la="ls -la"

# kubectl
autoload -Uz compinit
compinit
source <(kubectl completion zsh)
alias k=kubectl
compdef __start_kubectl k

# PROMPT (PS1 equivalent in zsh)
# Enable prompt substitution
setopt PROMPT_SUBST

# Git branch function for prompt
git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

export PROMPT='%F{25}@%n%f%F{61}[%f%F{31}%~%f%F{61}]%f%F{226}$(git_branch)%f%F{47}:%f'

# default k9s and kubectl editor
export EDITOR=nvim

# Zsh history configuration
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# precmd runs before each prompt (replaces PROMPT_COMMAND)
precmd() {
    # Save history after each command
    fc -W
}

# nvim = vim
alias vim="nvim"

# z
. $HOME/Documents/z/z.sh

export PATH="$HOME/go/bin:$PATH"
export PATH="/usr/local/go/bin:$PATH"
export PATH="/usr/local/bin:$PATH"

# keep this at the bottom
if [[ -v TMUX ]]
then
    tmux list-panes -s | awk 'END { if(NR == 1 && $4 ~ "0/") system("neofetch")}'
fi
