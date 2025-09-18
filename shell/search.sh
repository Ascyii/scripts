#!/bin/sh

# Usage: rgnvim KEYWORD
rg --vimgrep "$@" |
	fzf --delimiter : --nth 1,2,3,4 \
		--preview 'bat --style=numbers --color=always --highlight-line {2} {1}' |
	awk -F: '{print $1, $2}' |
	xargs -r sh -c 'nvim +"$1" "$0"'
