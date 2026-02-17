#!/usr/bin/env zsh

BG_DIR="$HOME/.config/bspwm/backgrounds"

if [ ! -d "$BG_DIR" ]; then
    notify-send "Error" "Wallpaper directory not found!"
    exit 1
fi

CHOSEN=$(ls "$BG_DIR" | grep -E ".jpg$|.png$|.webp$|.jpeg$" | while read -r line; do
    echo -en "$line\0icon\x1f$BG_DIR/$line\n"
done | rofi -dmenu -i -p "  Gallery" -show-icons -theme-str '
    window {
        width: 80%;
        height: 80%;
        border: 2px;
        border-color: #ffffff;
        border-radius: 0px;
        padding: 40px;
        background-color: #000000;
    }
    mainbox {
        children: [ inputbar, listview ];
        spacing: 20px;
    }
    inputbar {
        children: [ prompt, entry ];
        background-color: #000000;
        text-color: #ffffff;
        padding: 10px;
        border: 0px 0px 2px 0px;
        border-color: #333333;
    }
    prompt {
        text-color: #ffffff;
        padding: 0px 10px 0px 0px;
        font: "JetBrainsMono Nerd Font Bold 12";
    }
    entry {
        text-color: #ffffff;
        font: "JetBrainsMono Nerd Font 12";
        placeholder: "Search wallpaper...";
        placeholder-color: #555555;
    }
    listview {
        columns: 4;
        lines: 3;
        spacing: 30px;
        cycle: false;
        dynamic: true;
        layout: vertical;
        background-color: #000000;
        scrollbar: false;
    }
    element {
        orientation: vertical;
        padding: 15px;
        border-radius: 0px;
        background-color: #000000;
        text-color: #888888;
    }
    element selected {
        background-color: #222222;
        text-color: #ffffff;
        border: 1px;
        border-color: #ffffff;
    }
    element-icon {
        size: 250px;
        horizontal-align: 0.5;
        background-color: transparent;
    }
    element-text {
        horizontal-align: 0.5;
        vertical-align: 0.5;
        padding: 10px 0px 0px 0px;
        font: "JetBrainsMono Nerd Font Medium 10";
    }
')

if [ -z "$CHOSEN" ]; then
    exit 0
fi

feh --bg-fill "$BG_DIR/$CHOSEN"
notify-send -u low "Wallpaper Updated" "Changed to: $CHOSEN" --icon="$BG_DIR/$CHOSEN"
