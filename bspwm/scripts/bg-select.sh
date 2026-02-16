#!/bin/zsh

BG_DIR="$HOME/.config/bspwm/backgrounds"

CHOSEN=$(ls "$BG_DIR" | grep -E ".jpg$|.png$|.webp$" | while read -r line; do
    echo -en "$line\0icon\x1f$BG_DIR/$line\n"
done | rofi -dmenu -i -p "󰸉 Wallpaper" -show-icons -theme-str 'listview { columns: 3; } element { orientation: vertical; } element-icon { size: 150px; }')

if [ -z "$CHOSEN" ]; then
    exit 0
fi

feh --bg-fill "$BG_DIR/$CHOSEN"
notify-send "Wallpaper" "Set to $CHOSEN"
