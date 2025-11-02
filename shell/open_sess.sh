#!/usr/bin/env bash
set -euo pipefail

PROJECT_DIR=$(find ~/projects -mindepth 1 -maxdepth 1 -type d | fzf --prompt='Select project: ')
[ -z "$PROJECT_DIR" ] && exit 0

SESSION_NAME=$(basename "$PROJECT_DIR")

# If session exists, switch or attach depending on context
if tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
    if [ -n "${TMUX:-}" ]; then
        tmux switch-client -t "$SESSION_NAME"
    else
        tmux attach -t "$SESSION_NAME"
    fi
    exit 0
fi

# Choose startup command
if [ -f "$PROJECT_DIR/shell.nix" ]; then
    START_CMD="cd \"$PROJECT_DIR\" && nix-shell"
else
    START_CMD="cd \"$PROJECT_DIR\""
fi

# Create a new detached session
tmux new-session -d -s "$SESSION_NAME" "bash -c '$START_CMD; exec bash'"

# Create a second window running Neovim
tmux new-window -t "$SESSION_NAME" -n nvim "bash -c 'cd \"$PROJECT_DIR\" && nvim'"

# Attach or switch, depending on whether we're inside tmux
if [ -n "${TMUX:-}" ]; then
    tmux switch-client -t "$SESSION_NAME"
else
    tmux attach -t "$SESSION_NAME"
fi
