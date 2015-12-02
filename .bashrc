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

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

## some more ls aliases
#les() { ls --color -thorA $1 |less -R; }
#alias l='ls --color'
#alias ll='ls -thor'
#alias lla='ls -thorA'
#alias la='ls -A'
#alias .l='ls -d .*'
#alias .ll='ls -thord .*'
#
#alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
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

#cless () { pygmentize "$1" | less -R; }
alias cless='less -R'

calc () { echo $@ |tr ',' ' '|dc;  }

alias c='set -f; c'
#c () { c_arg=${*/,/}; dc -e "16k$c_arg f"|numfmt.pl; set +f; }
c () { echo "16k $* f"|tr -d , |dc ; set +f; }
mleft () {
    punch=${1:-"8:00"}
    sift=${2:-"8"}
    rem=$(dc -e "$sift 60 60 ** `date +%s` `date -d $punch +%s`-- p")
    dc -e "2k.0026 $rem *[$]nn[ (]n"
    date -d@$rem -u +"%H:%M)"
}

left () {
    punch=${1:-$(echo "8:00")}
    punch=$(sed "s/:/ /g"<<<"$punch")
    shft=8
    shft=${2:-$shft}
    while true; do
        dc -e " $shft 60 60**
        `date '+%H 60*%M+60*%S+'` 
        $punch r60*+60* --
        d60%r60/d60%r60/n[:]nn[:]nn[ ]p"|
        perl -pe 's/\b(\d)(?=\D)/0$1/g'|tr '\n' '\r'
        sleep 1
    done
}
since () 
{ 
    units $(dc -e "`date +%s` `date -d $1 +%s`-p")seconds 'hours;minutes;seconds'
}

made () {
    punch=`date -d ${1:-"8:00"} +%s`
    echo -en "\e[?25l"
    while true; do
        dc -e "4k`date +%s.%N |head -c15` $punch-.0026*[$]nn"
        echo -n '/$74.88'
        sleep ".05"
    done
    echo -en "\e[?25h"
}

s () { echo -en "\e[?25h"; }

alias clock="while true; do date|tr '\n' '\r'; sleep 1; done"
alias nclock=' echo -en "\e[?25l"; while true; do date +%Y/%m/%d-%H:%M:%S.%N|head -c 23;echo -en "\r"; sleep .001; done'
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
alias l='ls --color'
alias ll='ls -thor'
alias lla='ls -thorA'
alias la='ls -A'
alias .l='ls -d .*'
alias .ll='ls -thord .*'
alias mono="sed -e 's/\[[0-9;]*[a-zA-Z]//g'"
alias chomp='tr -d "\n"'
alias pathsearch='ls `echo $PATH|tr ":" " " `|grep'
export PS1='\u@\h:\W\$ '
alias ed="rlwrap -r -p'1;35;40' ed -vp:"
alias gren='grep -n --color=auto'
alias 64='base64'
alias n='nl -ba'
alias ,n='nl -ba'
alias cols='pr -Tw`tput cols`'
eas () { t=${1-2}; (sine.pl 960 $t 16000 |aplay -qr16 & sine.pl 853 $t 16000| aplay -qr16 &); } 
set +f

alias lisp="rlwrap -p'1;31;40' sbcl"
alias q=clear
alias v=vim
alias edspell="rlwrap -if /usr/share/dict/words -p'1;33;40' ed -p'>'"
alias vim='vim -p'

~/gip
export EDITOR='rlwrap -r -p'\''1;35;40'\'' ed -vp:'
