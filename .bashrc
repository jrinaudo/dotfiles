#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ..='cd ..'
alias diff='diff --color=auto'
alias grep='grep --color=auto'
alias ip='ip -color=auto'
alias ls='ls -hF --color=auto'
alias ll='ls -l'
alias la='ls -la'
alias ga='git add'
alias gaa='git add -A'
alias gap='git add -p'
alias gc='git commit'
alias gca='git commit --amend'
alias gcm='git commit -m'
alias gcob='git branch | fzf | xargs git checkout'
alias gcom='git checkout main'
alias gd='git diff'
alias gfom='git fetch origin main'
alias gft="git fetch origin 'refs/tags/*:refs/tags/*'"
alias glb='git branch --format "%(refname:short) %(upstream:short)" | awk '"'"'{if (!$2) print $1;}'"'"''
alias gl="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)'"
alias gp='git push'
alias gpf='git push --force-with-lease'
alias gpom='git pull origin main --ff-only'
alias gri='git rebase -i'
alias gs='git status'
alias reflector='sudo reflector --verbose --latest 30 --protocol https --sort rate --save /etc/pacman.d/mirrorlist'
alias svim='sudo vim'
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

export LESS='-R --use-color -Dd+r$Du+b$'
export MANPAGER="less -R --use-color -Dd+r -Du+b"

PS1='\W \$ '

# bash_history options
export HISTCONTROL=ignoreboth:erasedups
export HISTSIZE=10000
export HISTFILESIZE=10000

# bash-git-prompt
if [ -f "$HOME/.bash-git-prompt/gitprompt.sh" ]; then
    GIT_PROMPT_ONLY_IN_REPO=1
    GIT_PROMPT_FETCH_REMOTE_STATUS=0
    source $HOME/.bash-git-prompt/gitprompt.sh
fi

# FZF
source /usr/share/fzf/key-bindings.bash && source /usr/share/fzf/completion.bash

