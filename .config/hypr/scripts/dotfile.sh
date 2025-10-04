#!/bin/bash

DOT_FILE_PATH="$HOME/dotfiles"
SESSION_NAME="dot"

isHyprland(){
  env=$(echo -e $XDG_SESSION_DESKTOP)
  
  if [ "$XDG_SESSION_DESKTOP" = "Hyprland"];then
    return 0
  fi

  return 1
}

open_dot_files(){

  if [ ! -d $DOT_FILE_PATH ]; then
    notify-send "[dotfiles] Not Found" "Cannot Find dir: ${DOT_FILE_PATH}, Make Sure if Path Exist."
    # hyprctl notify -1 4000 "rgb(ff1ea3)" "fontsize:12 DotFile Not Found"  "Cannot Find dir: ${DOT_FILE_PATH}, Make Sure if Path Exist."
    exit 1
  fi

  if [ -n "$TMUX" ]; then
    # Already inside tmux: just create a new tab
    # hyprctl notify -1 4000 "rgb(ff1ea3)" "fontsize:12 DotFile opened in existing tmux session" "this is test"
    notify-send "[dotfiles] Found" "DotFile opened in existing tmux session"
    tmux new-window -c "$DOT_FILE_PATH" "nvim"
  else
    notify-send "[dotfiles] Found" "DotFile opened in new tmux session"
    # hyprctl notify -2 4000 "rgb(ff1ea3)" "fontsize:16 DotFile opened in new tmux session" "fontsize:13 this is test"
    # Not inside tmux: attach or create session
    
    kitty sh -c '
      SESSION_NAME="dot"
      DOT_FILE_PATH="$HOME/dotfiles"
      tmux has-session -t "$SESSION_NAME" 2>/dev/null && \
      tmux attach -t "$SESSION_NAME" || \
      tmux new-session -s "$SESSION_NAME" -c "$DOT_FILE_PATH" nvim
      exec $SHELL
    '
  fi
}

case $1 in 
  -opendf)
    open_dot_files
    ;;
  -syncdf)
    sync_dot_files
    ;;
  *)
  echo "Error: Invalid option '$1'"
  echo "Usage: $0 [-s | -o]"
  exit 1
    ;;
esac

