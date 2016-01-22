#!/bin/sh

#links files in home dir to ones in dotfiles repo
BAK="$HOME/bak"
REPO="$HOME/dotfiles"

mkdir -p $BAK
for target in $REPO/.[!.]*; do
  name=`basename $target`
  link=$HOME/$name
  if [ $name = '.git' ]; then continue; fi 
  if [ -e $link ]; then
    if [ -L $HOME/$name ]; then
      if [ ! `readlink $link` = $target ]; then
        printf "\033[1;31mWARNING!\033[0m existing link:\n"
        echo "$HOME/$name --> " `readlink $HOME/$name`
        rm -ri $HOME/$name
        if [ ! -e $link ]; then
          ln -s $target $link  && echo "$link lined to $target"
        else
          echo "no link formed"
        fi
        echo ""
      else
        echo "$link link already points to $target"
      fi
    else
      printf "\033[31mfile with name: $name already exits in $HOME, moving to $BAK\033[0m\n"
      mv -b $HOME/$name $BAK/
    fi
  else
    printf "\033[31m"
    ln -s $target $link  && printf "\033[32m$link lined to $target\033[0m\n"
    printf "\033[0m"
  fi
done
