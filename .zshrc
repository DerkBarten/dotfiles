# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/daniel/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
#
#

alias ls="ls -l --color=auto"
PROMPT=%B%F{172}[%B%F{107}%n%F{252}@%F{blue}%m%f%b%B%F{172}]%F{252}%f%~:%b
