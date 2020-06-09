#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ..='cd ..'
alias diff='diff --color=auto'
alias grep='grep --color=auto'
alias ls='ls -hF --color=auto'
alias la='ll -A'
alias ll='ls -l'
alias ga='git add'
alias gaa='git add -A'
alias gc='git commit'
alias gca='git commit --amend'
alias gcm='git commit -m'
alias gcod='git checkout develop'
alias gd='git diff'
alias gf='git fetch'
alias gl="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)'"
alias gp='git push'
alias gpf='git push --force-with-lease'
alias gs='git status'
alias reflector='sudo reflector --verbose --latest 10 --protocol http --protocol https --sort rate --save /etc/pacman.d/mirrorlist'
alias svim='sudo vim'
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias be='bundle exec'

export LESS=-R
export LESS_TERMCAP_mb=$'\E[1;31m'     # begin blink
export LESS_TERMCAP_md=$'\E[1;36m'     # begin bold
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline

man() {
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    command man "$@"
}

PS1='\W \$ '

# bash_history options
export HISTCONTROL=ignoreboth
export HISTSIZE=10000
export HISTFILESIZE=10000

# bash-git-prompt
if [ -f "$HOME/.bash-git-prompt/gitprompt.sh" ]; then
    GIT_PROMPT_ONLY_IN_REPO=1
    source $HOME/.bash-git-prompt/gitprompt.sh
fi

# FZF
source /usr/share/fzf/key-bindings.bash && source /usr/share/fzf/completion.bash

# rbenv
eval "$(rbenv init -)"

