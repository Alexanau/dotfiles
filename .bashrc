# ~/.bashrc: executed by bash(1) for non-login shells.

# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize


# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
## some more ls aliases

# Alias definitions.
if [ -f ~/.aliases ]; then
    . ~/.aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

index () { cat -n | grep "$*" | perl -pe 's/[^0-9]//g;$_.=", "; END {print "\n"}'; }
calc () { echo $@ |tr ',' ' '|dc;  }
c () { echo "16k $* f"|tr -d , |dc ; set +f; }
since () 
{ 
    units $(dc -e "`date +%s` `date -d $1 +%s`-p")seconds 'hours;minutes;seconds'
}
s () { echo -en "\e[?25h"; }
teatime () {
    t=${1-3}
    echo -en "\e[?25l"
    for i in `seq 1 60`; do
        echo -ne '\r['
        for j in `seq 1 $i`; do
            echo -n '#'
        done
        for j in `seq $i 59`;do
            echo -n ' '
        done
        echo -en "]"
        sleep $t
    done
    echo "[Done]"
    echo -en "\e[?25h"
}
les() { ls --color -thorA $1 |less -R; }

export PS1='\u@\h:\W\$ '
set +f
export EDITOR='rlwrap -r -p'\''1;35;40'\'' ed -vp:'
