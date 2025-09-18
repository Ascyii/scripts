#!/bin/sh

file=~/configuration/dotfiles/.config/hypr/hyprland.conf

echo "#" >>file &
sleep 1
sed -i '$ d' file &
