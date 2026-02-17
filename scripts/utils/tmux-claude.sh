#!/usr/bin/env bash
#
# tmux-claude.sh - Manage Claude Code sessions in tmux floating popups
#

# Configuration
CLAUDE_BIN="${CLAUDE_BIN:-$HOME/.local/bin/claude}"

# Get working directory
WORK_DIR="${1:-$(pwd)}"
[ -d "$WORK_DIR" ] && WORK_DIR="$(cd "$WORK_DIR" && pwd)" || WORK_DIR="$(pwd)"

# Generate session name from directory basename
SESSION_NAME="claude-$(basename "$WORK_DIR" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/-/g')"

# Debug output - remove after fixing
echo "DEBUG: WORK_DIR=$WORK_DIR"
echo "DEBUG: SESSION_NAME=$SESSION_NAME"
echo "DEBUG: CLAUDE_BIN=$CLAUDE_BIN"
echo "DEBUG: CLAUDE exists? $([ -x "$CLAUDE_BIN" ] && echo YES || echo NO)"
echo "Press Enter to continue..."
read

# Unset TMUX to allow nested session
unset TMUX

# Create or attach to session
exec tmux new-session -A -s "$SESSION_NAME" -c "$WORK_DIR" "$CLAUDE_BIN --dangerously-skip-permissions"
