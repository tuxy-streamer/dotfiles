#!/bin/bash
tmux_startup() {
	tmux new-session -ds temp_session && tmux run-shell "$HOME/.config/tmux/plugins/tmux-resurrect/scripts/restore.sh" && tmux kill-session -t temp_session
	alacritty --class=code -e tmux a -t "$(awk 'END {print $2}' "$HOME/.config/tmux/resurrect-store/last")" &
}
tmux_startup &
dunst &
feh --bg-fill --borderless /storage/personal/wallpaper/gruvbox/gruvbox-dark.png &
brave &
easyeffects &
setxkbmap -option caps:escape &
