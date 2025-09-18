#!/bin/sh

## wrapper to make unison dynamic
#net=$(ping -c 1 hahn1.one)
#echo $net
#
#if [ $net = "" ]; then
#	echo "cannot reach cloud"
#else
#fi

# TODO: implement net logic

unison MainAll -root "$HOME/synced" -root "ssh://jonas@hahn1.one/synced"

