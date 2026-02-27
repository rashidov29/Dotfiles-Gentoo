#!/bin/bash

DIR="HOME/Pictures/Screenshots"
FILENAME="Screenshot_(date +%Y-%m-%d_%H-%M-%S).png"
FULL_PATH="$DIR/$FILENAME"
SOUND="/usr/share/sounds/freedesktop/stereo/camera-shutter.oga"

mkdir -p "$DIR"
Dmenu colors and font

NB="#000000"
NF="#82629b"
SB="#301944"
SF="#cba6f7"
FN="JetBrainsMono Nerd Font-11"
The selection process

selected=$(echo -e "Area_Clipboard\nArea_Save\nFullscreen_Clipboard\nFullscreen_Save\nTimer_5s_Clipboard\nTimer_5s_Save" | dmenu -i -l 6 -p "Shot:" -fn "$FN" -nb "$NB" -nf "$NF" -sb "$SB" -sf "$SF")

if [ -z "$selected" ]; then
exit 0
fi

sleep 0.3

case "$selected" in
Area_Clipboard)
maim -s -u | xclip -selection clipboard -t image/png
aplay "$SOUND" &
notify-send "Screenshot" "Area copied to clipboard" -i camera-photo
;;
Area_Save)
maim -s -u "$FULL_PATH"
aplay "$SOUND" &
notify-send "Screenshot" "Saved to: $FILENAME" -i camera-photo
;;
Fullscreen_Clipboard)
maim -u | xclip -selection clipboard -t image/png
aplay "$SOUND" &
notify-send "Screenshot" "Fullscreen copied to clipboard" -i camera-photo
;;
Fullscreen_Save)
maim -u "$FULL_PATH"
aplay "$SOUND" &
notify-send "Screenshot" "Saved to: $FILENAME" -i camera-photo
;;
Timer_5s_Clipboard)
notify-send "Screenshot" "Taking shot in 5 seconds..." -t 2000
sleep 5
maim -u | xclip -selection clipboard -t image/png
aplay "$SOUND" &
notify-send "Screenshot" "Delayed shot copied to clipboard" -i camera-photo
;;
Timer_5s_Save)
notify-send "Screenshot" "Taking shot in 5 seconds..." -t 2000
sleep 5
maim -u "$FULL_PATH"
aplay "$SOUND" &
notify-send "Screenshot" "Delayed shot saved to: $FILENAME" -i camera-photo
;;
esac
