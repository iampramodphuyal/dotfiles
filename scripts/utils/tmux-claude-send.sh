#!/usr/bin/env bash
#
# tmux-claude-send.sh - Send text selection to Claude Code session
#
# Usage: tmux save-buffer - | tmux-claude-send.sh [working_directory]
#
# This script:
#   1. Reads selected text from stdin (piped from tmux buffer)
#   2. Creates/ensures Claude session exists for the directory
#   3. Sends the selection to Claude (wrapped in code block)
#   4. Attaches to the session
#
# Keybinding usage:
#   bind-key S display-popup -E ... "tmux save-buffer - | tmux-claude-send.sh '#{pane_current_path}'"
#

set -e

# Configuration
# Use full path to claude since popup shell may not have ~/.local/bin in PATH
CLAUDE_BIN="${CLAUDE_BIN:-$HOME/.local/bin/claude}"
CLAUDE_CMD="${CLAUDE_CMD:-$CLAUDE_BIN --dangerously-skip-permissions}"

# Get working directory
WORK_DIR="${1:-$(pwd)}"
WORK_DIR="$(cd "$WORK_DIR" && pwd)"

# Read selection from stdin
SELECTION=$(cat)

# Generate session name (same logic as tmux-claude.sh)
generate_session_name() {
    local dir="$1"
    local basename
    basename="$(basename "$dir")"

    if [ "$basename" = "$USER" ] || [ "$dir" = "$HOME" ]; then
        basename="home"
    fi

    local sanitized
    sanitized=$(echo "$basename" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/-/g' | sed 's/--*/-/g' | sed 's/^-//;s/-$//')

    echo "claude-${sanitized}"
}

SESSION_NAME=$(generate_session_name "$WORK_DIR")

# Create session if doesn't exist
if ! tmux has-session -t "=$SESSION_NAME" 2>/dev/null; then
    tmux new-session -d -s "$SESSION_NAME" -c "$WORK_DIR" "$CLAUDE_CMD"
    # Wait for Claude to initialize
    sleep 0.5
fi

# Send the selection to Claude (if not empty)
if [ -n "$SELECTION" ]; then
    # Format: wrap in code block for better readability
    # Send text using send-keys with -l (literal) to handle special chars
    tmux send-keys -t "=$SESSION_NAME" -l "Regarding this code:"
    tmux send-keys -t "=$SESSION_NAME" Enter
    tmux send-keys -t "=$SESSION_NAME" -l '```'
    tmux send-keys -t "=$SESSION_NAME" Enter
    tmux send-keys -t "=$SESSION_NAME" -l "$SELECTION"
    tmux send-keys -t "=$SESSION_NAME" Enter
    tmux send-keys -t "=$SESSION_NAME" -l '```'
    tmux send-keys -t "=$SESSION_NAME" Enter
    tmux send-keys -t "=$SESSION_NAME" Enter
    # Don't press Enter - let user add their question
fi

# Attach to session (unset TMUX for popup context)
unset TMUX
exec tmux attach-session -t "=$SESSION_NAME"
