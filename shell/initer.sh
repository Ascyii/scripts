#!/bin/sh

echo "WARNING THIS COULD BREAK THINGS. CONFIRM BY C-C!"
cat

mkdir -p $HOME/projects
mkdir -p $HOME/configuration

git clone git@gitlab.gwdg.de:j.hahn02/scripts.git $HOME/projects/scripts
git clone git@gitlab.gwdg.de:j.hahn02/nixos.git $HOME/configuration/nixos
git clone git@gitlab.gwdg.de:j.hahn02/dotfiles.git $HOME/configuration/dotfiles
git clone git@gitlab.gwdg.de:j.hahn02/brainstore.git $HOME/management/brainstore

cd $HOME/configuration/dotfiles
bash $HOME/configuration/dotfiles/install.sh

cd

#scp -r syncer:sync/office $HOME/management

# optional insta reabiuld when on nix
echo 'rebuilding nix - if there'
sudo nixos-rebuild switch --flake '/home/jonas/configuration/nixos#'
