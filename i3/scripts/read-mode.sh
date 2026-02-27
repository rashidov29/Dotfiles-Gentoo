#!/bin/bash

FLAG_FILE="/tmp/read_mode_active"

if [ -f "$FLAG_FILE" ]; then
    rm "$FLAG_FILE"
    redshift -x

    notify-send "Mode Switch" "Reading Mode Deactivated. Notifications resumed."
else
    notify-send "Mode Switch" "Reading Mode Active! (Silencing in 1.5s)" -t 500 -u critical

    sleep 1.7

    redshift -O 2500
    touch "$FLAG_FILE"

fi
