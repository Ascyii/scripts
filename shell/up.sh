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

# Temporary file for logging statuses
TMP_LOG=$(mktemp)

process_repo() {
    local repo="$1"
    local status="ok"

    if [ -d "$repo/.git" ]; then
        echo "Processing $repo..."
        (
            cd "$repo" || exit
            git fetch
            git add .
            git commit -m "$COMMIT_MSG" >/dev/null 2>&1 || true
            if ! git pull --rebase; then
                status="conflict"
            else
                git push || status="push-failed"
            fi

            echo "$repo:$status" >>"$TMP_LOG"
            echo "Done: $repo ($status)"
        )
    else
        echo "Skipping $repo: not a git repository"
        echo "$repo:skipped" >>"$TMP_LOG"
    fi
}

for repo in "${REPOS[@]}"; do
    process_repo "$repo" &
done

wait
echo "All repositories processed."
echo

# Summarize results
echo "=== Summary ==="
if grep -q "conflict" "$TMP_LOG"; then
    grep "conflict" "$TMP_LOG" | while IFS=: read -r repo _; do
        echo "⚠️  Conflict detected in: $repo"
    done
else
    echo "No conflicts detected."
fi

if grep -q "push-failed" "$TMP_LOG"; then
    grep "push-failed" "$TMP_LOG" | while IFS=: read -r repo _; do
        echo "⚠️  Push failed for: $repo"
    done
fi

rm -f "$TMP_LOG"
