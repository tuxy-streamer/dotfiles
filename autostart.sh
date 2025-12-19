#!/usr/bin/env bash
source "$HOME/.bashrc"

touchpad_setup() {
  touchpad="ELAN0787:00 04F3:321A Touchpad"
  xinput set-prop "$touchpad" "libinput Tapping Enabled" 1
  xinput set-prop "$touchpad" "libinput Tapping Drag Enabled" 1
  xinput set-prop "$touchpad" "libinput Tapping Drag Lock Enabled" 1
  xinput set-prop "$touchpad" "libinput Tapping Button Mapping Enabled" 1 0
  xinput set-prop "$touchpad" "libinput Natural Scrolling Enabled" 1
  xinput set-prop "$touchpad" "libinput Disable While Typing Enabled" 1
  xinput set-prop "$touchpad" "libinput Clickfinger Button Mapping Enabled" 1 0
  xinput set-prop "$touchpad" "libinput Horizontal Scroll Enabled" 1
  xinput set-prop "$touchpad" "libinput Middle Emulation Enabled" 1
  xinput set-prop "$touchpad" "libinput Accel Speed" 0.3
}

touchpad_setup &
gsettings set org.gnome.desktop.interface color-scheme "prefer-dark" &
tmux_startup &
dunst &
feh --bg-fill --borderless /storage/personal/wallpaper/gruvbox/girl-reading-book.png &
# hyprpaper &
zen-twilight &
easyeffects &
setxkbmap -option caps:escape &
# picom &
sleep 3 && time_main &
syncthing &
