#!/bin/bash
STATE_FILE="/tmp/pomodoro_state"
WORK_TIME=$((25 * 60))
SHORT_BREAK_TIME=$((5 * 60))
LONG_BREAK_TIME=$((15 * 60))
CYCLES_BEFORE_LONG_BREAK=3

if [ "$1" == "toggle" ]; then
    if [ ! -f "$STATE_FILE" ]; then
        echo "WORK $(( $(date +%s) + WORK_TIME )) 1" > "$STATE_FILE"
        notify-send "Pomodoro" "Session started (25m)"
    else
        rm -f "$STATE_FILE"
        notify-send "Pomodoro" "Stopped"
    fi
    exit 0
fi

if [ ! -f "$STATE_FILE" ]; then
    echo "󰔟 Idle"
    exit 0
fi

read -r STATE END_TIME CYCLE < "$STATE_FILE"
NOW=$(date +%s)

if [ "$NOW" -ge "$END_TIME" ]; then
    if [ "$STATE" == "WORK" ]; then
        if [ "$CYCLE" -ge "$CYCLES_BEFORE_LONG_BREAK" ]; then
            STATE="LONG_BREAK"
            END_TIME=$(( NOW + LONG_BREAK_TIME ))
            CYCLE=0
            notify-send "Pomodoro" "Long Break! (15m)"
        else
            STATE="SHORT_BREAK"
            END_TIME=$(( NOW + SHORT_BREAK_TIME ))
            notify-send "Pomodoro" "Short Break! (5m)"
        fi
    else
        STATE="WORK"
        END_TIME=$(( NOW + WORK_TIME ))
        CYCLE=$(( CYCLE + 1 ))
        notify-send "Pomodoro" "Work Time! (25m)"
    fi
    echo "$STATE $END_TIME $CYCLE" > "$STATE_FILE"
fi

REMAINING=$(( END_TIME - NOW ))
MINUTES=$(( REMAINING / 60 ))
SECONDS=$(( REMAINING % 60 ))
FORMATTED=$(printf "%02d:%02d" "$MINUTES" "$SECONDS")

if [ "$STATE" == "WORK" ]; then
    echo "󱎫 $FORMATTED ($CYCLE/$CYCLES_BEFORE_LONG_BREAK)"
elif [ "$STATE" == "SHORT_BREAK" ]; then
    echo "󰔟 Break $FORMATTED"
else
    echo "󰔟 Long $FORMATTED"
fi
