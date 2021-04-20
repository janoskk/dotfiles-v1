#!/bin/sh
#
# Create symlinks to the $HOME directory
#

for i in *; do 
  [[ "$i" =~ ^(README.md|setup.sh)$ ]] && continue
  ln -s "$PWD/$i" "$HOME/.$i"
done

echo "unalias gcl" > $HOME/.oh-my-zsh/custom/some-unsets.zsh
echo ". ~/.profile" > $HOME/.oh-my-zsh/custom/zz-load-profile.zsh
