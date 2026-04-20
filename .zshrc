#
# ~/.zshrc
#

# Set keyboard layout (Linux/X11 only)
if [[ "$OSTYPE" == linux* ]] && command -v setxkbmap &>/dev/null; then
    setxkbmap -layout us intl
fi

# Change the window title of X terminals
use_color=true

alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias more=less

# Zsh history options
setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# precmd runs before each prompt (replaces PROMPT_COMMAND)
precmd() {
    fc -W
}

# ls
alias ls="ls --color=auto"
alias la="ls -la"

# kubectl
autoload -Uz compinit
compinit
if command -v kubectl &>/dev/null; then
    source <(kubectl completion zsh)
    alias k=kubectl
    compdef __start_kubectl k
fi

# netshoot: ephemeral debug pod (bash). Optional arg: namespace.
netshoot() {
    kubectl run "netshoot-$RANDOM" --rm -it \
        --image=nicolaka/netshoot \
        ${1:+-n "$1"} \
        --command -- /bin/bash
}

# PROMPT
setopt PROMPT_SUBST

git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

export PROMPT='%F{25}@%n%f%F{61}[%f%F{31}%~%f%F{61}]%f%F{226}$(git_branch)%f%F{47}:%f'

# default editor
export EDITOR=nvim

# nvim = vim
alias vim="nvim"

# z
[[ -f "$HOME/Documents/z/z.sh" ]] && . "$HOME/Documents/z/z.sh"

# PATH
export PATH="$HOME/go/bin:$PATH"
export PATH="/usr/local/go/bin:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$PATH:$HOME/.dotnet"
export PATH="$PATH:$HOME/.pulumi/bin"
export PATH="$PATH:$HOME/.yarn/bin"
export PATH="$PATH:$HOME/.local/bin"

# Linux-specific PATH
if [[ "$OSTYPE" == linux* ]]; then
    export PATH="$PATH:/home/arthurcgc/.spicetify"
    export PATH="$PATH:/opt/rocm/bin"
fi

# SSH keys via keychain (Linux)
if [[ "$OSTYPE" == linux* ]] && command -v keychain &>/dev/null; then
    eval $(keychain -q --eval github/id_ed25519)
    eval $(keychain -q --eval gitlab/id_ed25519)
fi

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv &>/dev/null; then
    eval "$(pyenv init -)"
fi

# npm global packages
unset NPM_CONFIG_PREFIX

# GitHub Personal Access Token
if command -v pass &>/dev/null; then
    export GITHUB_PERSONAL_ACCESS_TOKEN="$(pass show github/personal-access-token 2>/dev/null)"
fi

# Fix stale XAUTHORITY after SDDM re-login (Linux/X11 only)
if [[ "$OSTYPE" == linux* ]] && [[ -n "$DISPLAY" ]] && [[ ! -f "$XAUTHORITY" ]]; then
    export XAUTHORITY=$(find /tmp -maxdepth 1 -name 'xauth_*' -user "$USER" -print -quit 2>/dev/null)
fi

# keep this at the bottom
if [[ -v TMUX ]]; then
    tmux list-panes -s | awk 'END { if(NR == 1 && $4 ~ "0/") system("neofetch")}'
fi

# OpenClaw
if [[ -f "$HOME/.openclaw/completions/openclaw.zsh" ]]; then
    export OPENCLAW_ALLOW_INSECURE_PRIVATE_WS=1
    source "$HOME/.openclaw/completions/openclaw.zsh"
elif [[ -f "$HOME/.openclaw/completions/openclaw.bash" ]]; then
    export OPENCLAW_ALLOW_INSECURE_PRIVATE_WS=1
    source "$HOME/.openclaw/completions/openclaw.bash"
fi
