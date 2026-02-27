#!/usr/bin/env bash

WALLPAPER_DIR="$HOME/.config/i3/backgrounds/"

while true; do
    feh --bg-fill --randomize "$WALLPAPER_DIR"/*
    sleep 3000
done
