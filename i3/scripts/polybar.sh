#!/usr/bin/env bash

RETRO="Retro-Style"
MODERN="Modern-Style"

CHOSEN=$(echo -e "$RETRO\n$MODERN" | rofi -dmenu -i -p "Polybar Style" -theme-str 'window { width: 250px; border: 1px; border-color: #444444; background-color: #000000; } listview { lines: 2; } element { padding: 10px; text-color: #777777; } element selected { background-color: #222222; text-color: #ffffff; }')

if [ "$CHOSEN" = "$RETRO" ]; then
    killall -9 polybar
    while pgrep -u $UID -x polybar >/dev/null; do sleep 0.1; done
    polybar -c "$HOME/.config/polybar/config.ini" main &
elif [ "$CHOSEN" = "$MODERN" ]; then
    killall -9 polybar
    while pgrep -u $UID -x polybar >/dev/null; do sleep 0.1; done
    polybar -c "$HOME/.config/polybar/config2.ini" main &
fi
