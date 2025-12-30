#!/usr/bin/env bash

tmux_startup() {
  tmux new-session -ds temp_session && tmux run-shell "$HOME/.config/tmux/plugins/tmux-resurrect/scripts/restore.sh" && tmux kill-session -t temp_session
  kitty --class=code -e tmux a -t "$(awk 'END {print $2}' "$HOME/.config/tmux/resurrect-store/last")" &
  kitty --class=note -e tmux a -t "notes" &
}

tmux_open() {
  local selected
  selected=$(zoxide query --list | fzf --height=40%)
  [[ -z "$selected" ]] && return 1

  local session_name
  session_name=$(basename "$selected")
  tmux has-session -t "$session_name" 2>/dev/null &&
    tmux attach -t "$session_name" ||
    tmux new-session -c "$selected" -s "$session_name"
}
