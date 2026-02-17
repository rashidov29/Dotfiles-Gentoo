#!/bin/bash

DIR="$HOME/Pictures/Screenshots"
FILENAME="Screenshot_$(date +%Y-%m-%d_%H-%M-%S).png"
FULL_PATH="$DIR/$FILENAME"
SOUND="/usr/share/sounds/freedesktop/stereo/camera-shutter.oga"

mkdir -p "$DIR"

option0="󰆞  Area (Clipboard)"
option1="󰆞  Area (Save)"
option2="󰹑  Fullscreen (Clipboard)"
option3="󰹑  Fullscreen (Save)"
option4="󱑆  Timer 5s (Clipboard)"
option5="󱑆  Timer 5s (Save)"

options="$option0\n$option1\n$option2\n$option3\n$option4\n$option5"
selected="$(echo -e "$options" | rofi -lines 6 -dmenu -p "󰄀 Shot" -theme-str 'window {width: 400px;}')"

if [ ! -z "$selected" ]; then
    sleep 0.3
    case $selected in
        "$option0")
            maim -s -u | xclip -selection clipboard -t image/png
            aplay "$SOUND" &
            notify-send "Screenshot" "Area has been copied to clipboard" -i camera-photo
            ;;
        "$option1")
            maim -s -u "$FULL_PATH"
            aplay "$SOUND" &
            notify-send "Screenshot" "Area saved as $FILENAME" -i camera-photo
            ;;
        "$option2")
            maim -u | xclip -selection clipboard -t image/png
            aplay "$SOUND" &
            notify-send "Screenshot" "Fullscreen has been copied to clipboard" -i camera-photo
            ;;
        "$option3")
            maim -u "$FULL_PATH"
            aplay "$SOUND" &
            notify-send "Screenshot" "Fullscreen saved as $FILENAME" -i camera-photo
            ;;
        "$option4")
            notify-send "Screenshot" "Taking shot in 5 seconds..." -t 2000
            sleep 5
            maim -u | xclip -selection clipboard -t image/png
            aplay "$SOUND" &
            notify-send "Screenshot" "Delayed shot copied to clipboard" -i camera-photo
            ;;
        "$option5")
            notify-send "Screenshot" "Taking shot in 5 seconds..." -t 2000
            sleep 5
            maim -u "$FULL_PATH"
            aplay "$SOUND" &
            notify-send "Screenshot" "Delayed shot saved as $FILENAME" -i camera-photo
            ;;
    esac
fi
