#!/bin/zsh

PLAYER_STATUS=$(playerctl status 2>/dev/null)

if [ "$PLAYER_STATUS" = "Playing" ]; then
    echo "%{F#7b2cbf}󰎈 %{F-}$(playerctl metadata --format "{{ artist }} - {{ title }}" | cut -c1-40)"
elif [ "$PLAYER_STATUS" = "Paused" ]; then
    echo "%{F#45475a}󰏤 %{F-}$(playerctl metadata --format "{{ artist }} - {{ title }}" | cut -c1-40)"
else
    echo ""
fi
