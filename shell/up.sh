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

process_repo() {
    local repo="$1"

    if [ -d "$repo/.git" ]; then
        echo "Processing $repo..."
        (
            cd "$repo" || exit
            git fetch
            git add .
            git commit -m "$COMMIT_MSG" >/dev/null 2>&1 || true
            git pull --rebase
            git push
            echo "Done: $repo"
        )
    else
        echo "Skipping $repo: not a git repository"
    fi
}

for repo in "${REPOS[@]}"; do
    process_repo "$repo" &
done

wait
echo "All repositories processed."
