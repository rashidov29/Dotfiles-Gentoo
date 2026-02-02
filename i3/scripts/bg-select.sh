#!/usr/bin/env bash

WALL_DIR="$HOME/.config/i3/backgrounds/"
ROFI_THEME="$HOME/.config/rofi/wall_selector.rasi"

list_walls() {
    find "$WALL_DIR" -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.jpeg" -o -name "*.webp" \) | while read -r path; do
        echo -en "$(basename "$path")\0icon\x1f$path\n"
    done
}

selected=$(list_walls | rofi -dmenu -i -p "Wallpaper" -theme "$ROFI_THEME")

if [ -z "$selected" ]; then
    exit 0
fi

full_path="$WALL_DIR/$selected"

if [ -f "$full_path" ]; then
    feh --bg-fill "$full_path"
    echo "feh --bg-fill '$full_path'" > "$HOME/.fehbg"
    notify-send "System" "Wallpaper changed" -i "$full_path"
fi
