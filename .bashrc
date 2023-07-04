#
# ~/.bashrc
#

# Change the window title of X terminals
use_color=true

alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias np='nano -w PKGBUILD'
alias more=less

# Enable history appending instead of overwriting.  #139609
shopt -s histappend

## arthurcgc ##
alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias np='nano -w PKGBUILD'
alias more=less

# la = ls -la
alias ls="ls --color=auto"
alias la="ls -la"

# kubectl
source <(kubectl completion bash)
alias k=kubectl
complete -F __start_kubectl k

# PS1
export PS1="\[\033[38;5;25m\]@\u\[$(tput sgr0)\]\[\033[38;5;61m\][\[$(tput sgr0)\]\[\033[38;5;31m\]\w\[$(tput sgr0)\]\[\033[38;5;61m\]]\[$(tput sgr0)\]\[\033[38;5;226m\]\$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/')\[$(tput sgr0)\]\[\033[38;5;47m\]:\[$(tput sgr0)\]"

# default k9s and kubectl editor
export EDITOR=nvim

# bash history
## Avoid duplicates
HISTCONTROL=ignoredups:erasedups # Ubuntu default is ignoreboth
## Enable history appending instead of overwriting.  #139609
shopt -s histappend
## After each command, append to the history file and reread it
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

#tsuru
alias tprod="tsuru --target prod"
alias tlab="tsuru --target lab"
alias tlocal="tsuru --target local"
alias t="tsuru"

# bashrc shortcut
alias bashrc="vim ${HOME}/.bashrc"

# nvim = vim
alias vim="nvim"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/arthurcgc/Downloads/google-cloud-sdk/path.bash.inc' ]; then . '/home/arthurcgc/Downloads/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/arthurcgc/Downloads/google-cloud-sdk/completion.bash.inc' ]; then . '/home/arthurcgc/Downloads/google-cloud-sdk/completion.bash.inc'; fi

# z
. $HOME/Documents/z/z.sh

export PATH="$HOME/go/bin:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH=$PATH:/home/arthurcgc/.spicetify
