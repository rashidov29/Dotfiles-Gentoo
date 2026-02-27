#!/bin/bash

NB="#000000"
NF="#82629b"
SB="#301944"
SF="#cba6f7"
FN="JetBrainsMono Nerd Font-11"

options="󰌾 Lock\n󰐥 Shutdown\n󰑐 Reboot\n󰤄 Suspend\n󰍃 Logout"

selected=$(echo -e "$options" | dmenu -i -p "System:" -fn "$FN" -nb "$NB" -nf "$NF" -sb "$SB" -sf "$SF")

case "$selected" in
*Lock)
betterlockscreen -l blur ;;
*Shutdown)
doas /sbin/poweroff ;;
*Reboot)
doas /sbin/reboot ;;
*Suspend)
doas /sbin/zzz ;;
*Logout)
pkill -u $USER ;;
esac
