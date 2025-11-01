#!/usr/bin/env bash

# List of directories with git repositories
REPOS=(
    "/home/jonas/nixos"
    "/home/jonas/dotfiles"
    "/home/jonas/.config/nvim"
    "/home/jonas/projects/scripts"
    "/home/jonas/projects/university"
)

# Commit message
COMMIT_MSG="auto up $(uptime)"

for repo in "${REPOS[@]}"; do
    if [ -d "$repo/.git" ]; then
        echo "Processing $repo...


		"
        cd "$repo" || continue
        git fetch
        git add .
        git commit -m "$COMMIT_MSG"
        git pull --rebase
        git push
    else
        echo "Skipping $repo: not a git repository"
    fi
done
