#!/usr/bin/env bash

tmux_startup() {
  tmux new-session -ds temp_session && tmux run-shell "$HOME/.config/tmux/plugins/tmux-resurrect/scripts/restore.sh" && tmux kill-session -t temp_session
  kitty --class=code -e tmux a -t "$(awk 'END {print $2}' "$HOME/.config/tmux/resurrect-store/last")" &
  kitty --class=note -e tmux a -t "notes" &
}
