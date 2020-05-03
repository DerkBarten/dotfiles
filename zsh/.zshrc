# Lines configured by zsh-newuser-install
HISTFILE=$XDG_DATA_HOME/histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/daniel/.zshrc'

autoload -Uz compinit
autoload -U colors && colors
compinit
# End of lines added by compinstall
#
#

alias ls="ls --color=auto --group-directories-first"
alias q="exit"

#PROMPT="%B%F{172}[%B%F{107}%n%F{252}@%F{blue}%m%\ %F{252}%~%F{172}]%F{252}%b\$ "

# Stole this one from Luke smith
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

[ -f "$HOME/.config/env" ] && source $HOME/.config/env
