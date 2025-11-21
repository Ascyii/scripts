#!/usr/bin/env bash

HOST=$(hostname)

case "$HOST" in
    "minoxy")
        kmonad ~/dotfiles/home/dot-kmonad/hyper.kbd &
        ;;
    "thinix")
        kmonad ~/dotfiles/home/dot-kmonad/thinkpad.kbd &
        ;;
esac

disown
