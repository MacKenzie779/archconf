#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ssha='eval $(ssh-agent -s); ssh-add ~/.ssh/artemisKey'
alias push_dirname='git add .; git commit -m $(basename $(pwd)); git push'
alias push='git add .; git commit -m "init"; git push'
PS1='[\u@\h \W]\$ '

# opam configuration
[[ ! -r /home/user/.opam/opam-init/init.zsh ]] || source /home/user/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

