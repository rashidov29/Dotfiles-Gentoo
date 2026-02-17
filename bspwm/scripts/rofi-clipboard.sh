#!/usr/bin/env zsh

TMP_DIR="/tmp/rofi_clipboard"
mkdir -p "$TMP_DIR"
rm -f "$TMP_DIR"/*

if ! pgrep -x "copyq" > /dev/null; then
    notify-send "Clipboard Error" "CopyQ is not running!"
    exit 1
fi

DATA=$(copyq eval '
    var result = "";
    var num = Math.min(count(), 30);
    for (var i = 0; i < num; ++i) {
        var mimes = formats();
        var isImage = mimes.indexOf("image/png") >= 0 || mimes.indexOf("image/jpeg") >= 0;

        if (isImage) {
            var path = "'$TMP_DIR'/img_" + i + ".png";
            write(path, read(i), "image/png");
            result += "󰋩 Image " + i + " [" + i + "]\0icon\x1f" + path + "\n";
        } else {
            var text = str(read(i)).replace(/[\0\n\r]/g, " ").substring(0, 80);
            if (text.trim().length == 0) continue;
            result += text + " [" + i + "]\0icon\x1fedit-paste\n";
        }
    }
    result;
')

if [[ -z "$DATA" ]]; then
    DATA="Clipboard is empty... [0]"
fi

SELECTED=$(echo -en "$DATA" | rofi -dmenu -i -p "󰅌 Clipboard" -show-icons -theme-str '
    window { width: 1000px; height: 750px; }
    listview { columns: 2; spacing: 15px; fixed-height: false; }
    element { orientation: vertical; padding: 20px; }
    element-icon { size: 250px; horizontal-align: 0.5; vertical-align: 0.5; }
    element-text { horizontal-align: 0.5; vertical-align: 0.5; }
')

if [[ -n "$SELECTED" ]]; then
    INDEX=$(echo "$SELECTED" | grep -o "\[[0-9]*\]" | tr -d "[]")
    if [[ -n "$INDEX" ]]; then
        copyq select "$INDEX"
        notify-send "Clipboard" "Item #$INDEX ready to paste"
    fi
fi
