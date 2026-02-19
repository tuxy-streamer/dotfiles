#!/usr/bin/env bash

themes=(
    "gruvbox"
    "gruvbox-material"
    "nord"
    "onedark"
    "kanagawa"
    "everforest"
    "dracula"
    "catppuccin"
    "alabaster"
    "solarized-dark"
)

# Detect current theme
current_theme=""

detect_current_theme(){
    local theme_line

    theme_line=$(grep "source = ~/.config/hypr/colors/" "$CONFIG"/hypr/hyprland.conf)
    current_theme=$(echo "$theme_line" | cut -d '/' -f 5 | cut -d '.' -f 1)

    echo "$theme_line"
    echo "$current_theme"
}

hypr_theme_switcher(){
    local new_line, old_line

    new_line="source = ~/.config/hypr/colors/$1.conf"
    old_line="source = ~/.config/hypr/colors/.*\.conf"
    sed -i "s|^$old_line|$new_line|" "$CONFIG"/hypr/hyprland.conf
}


kitty_theme_switcher(){
    local new_line, old_line

    new_line="include $1.conf"
    old_line="include .*\.conf"
    sed -i "s|^$old_line|$new_line|" "$CONFIG"/kitty/kitty.conf
}

rofi_theme_switcher(){
    local new_line, old_line

    new_line="@theme \"$1.rasi\""
    old_line="@theme \".*\.rasi\""
    sed -i "s|^$old_line|$new_line|" "$CONFIG"/rofi/config.rasi
}

theme_switch_launcher(){
    local selected

    selected=$( printf "%s\n" "${themes[@]}" | sort | rofi -dmenu)
    theme_switcher "$selected"
}

theme_switcher(){
    detect_current_theme
    echo "$current_theme"
    theme="$1"
    [[ "$theme" == "$current_theme" ]] && echo "This is the current theme." && return
    hypr_theme_switcher "$theme"
    kitty_theme_switcher "$theme"
    rofi_theme_switcher "$theme"
}
