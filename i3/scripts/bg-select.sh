#!/usr/bin/env zsh

BG_DIR="$HOME/.config/i3/backgrounds"

if [ ! -d "$BG_DIR" ]; then
notify-send "Error" "Wallpaper directory not found!"
exit 1
fi

CHOSEN=$(nsxiv -t -o "$BG_DIR" | tail -n 1)

if [ -z "$CHOSEN" ]; then
exit 0
fi

feh --bg-fill "$CHOSEN"
notify-send -u low "Wallpaper Updated" "Applied successfully" --icon="$CHOSEN"
