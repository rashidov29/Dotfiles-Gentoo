#!/bin/bash
if [ "$(i3-msg -t get_tree | grep -c 'music_popup_term')" -gt 0 ]; then
    i3-msg '[instance="music_popup_term"] kill'
    exit 0
fi

kitty --name music_popup_term -o initial_window_width=300 -o initial_window_height=150 -e sh -c "
while true; do
    clear
    echo -e '\e[35m󰎈 $(playerctl metadata title | cut -c1-25)\e[0m'
    echo -e '\e[34m󰠃 $(playerctl metadata artist | cut -c1-25)\e[0m'
    echo '-----------------------'
    echo ' [p] Play/Pause'
    echo ' [n] Next'
    echo ' [b] Previous'
    echo ' [q] Close'
    read -n 1 input
    case \$input in
        p) playerctl play-pause ;;
        n) playerctl next ;;
        b) playerctl previous ;;
        q) exit ;;
    esac
done"
