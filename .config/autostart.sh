#!/bin/bash
tmux_startup() {
	tmux new-session -ds temp_session && tmux run-shell "$HOME/.config/tmux/plugins/tmux-resurrect/scripts/restore.sh" && tmux kill-session -t temp_session
	alacritty --class=code -e tmux a &
	alacritty --class=notes -e tmux a -t notes &
}
tmux_startup &
picom -b &
dunst &
feh --bg-fill --borderless /storage/personal/wallpaper/gruvbox/gruvbox-dark.png &
brave &
easyeffects &
telegram-desktop &
rnote &
