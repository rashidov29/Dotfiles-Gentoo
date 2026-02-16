#!/usr/bin/env bash

WALLPAPER_DIR="$HOME/.config/bspwm/backgrounds/"

while true; do
    feh --bg-fill --randomize "$WALLPAPER_DIR"/*
    sleep 1000
done
