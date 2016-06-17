export `dircolors`
# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _correct
zstyle ':completion:*' expand prefix
zstyle ':completion:*' file-sort name
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' ignore-parents pwd directory
zstyle ':completion:*' insert-unambiguous false
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}' 'r:|[._-]=** r:|=**'
zstyle ':completion:*' menu select=0
zstyle ':completion:*' original true
zstyle ':completion:*' preserve-prefix '//[^/]##/'
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
zstyle :compinstall filename '/home/austin/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
unset LS_COLORS
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd nomatch notify
unsetopt extendedglob
bindkey -v
# End of lines configured by zsh-newuser-install

# vim terminal
bindkey -v
export KEYTIMEOUT=10
bindkey -M viins 'lkj' vi-cmd-mode
#mode prompt
autoload -U promptinit colors && colors
promptinit

precmd() {
  PROMPT="%B[i] %F{black}%n:%.%# %f%b"
}
zle-keymap-select() {
  PROMPT="%B[i] %F{black}%n:%.%# %f%b"
  [[ $KEYMAP = vicmd ]] && PROMPT="%B[N] %F{black}%n:%.%# %f%b"
  () { return $__prompt_status }
  zle reset-prompt
}
zle-line-init() {
  typeset -g __prompt_status="$?"
}
zle -N zle-keymap-select
zle -N zle-line-init

# Functions

calc () {
  #calculator
  echo "16k $* f"|tr -d , |dc;
  set +f;
}

# Include aliases file

if [ -f ~/.aliases ]; then
    . ~/.aliases
fi

export PATH=$PATH:~/bin
export EDITOR='vim'
export TERM=linux
#
