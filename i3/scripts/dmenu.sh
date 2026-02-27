#!/bin/bash

NB="#000000"
NF="#82629b"
SB="#301944"
SF="#cba6f7"
FN="JetBrainsMono Nerd Font-11"

dmenu_run -i -p "Run:" -fn "$FN" -nb "$NB" -nf "$NF" -sb "$SB" -sf "$SF"
