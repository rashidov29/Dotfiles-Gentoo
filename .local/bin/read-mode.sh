#!/bin/bash

FLAG_FILE="/tmp/read_mode_active"

if [ -f "$FLAG_FILE" ]; then
    # --- MODU KAPATMA ---
    rm "$FLAG_FILE"
    redshift -x

    # Dunst'ı uyandır ve bildirimi gönder
    dunstctl set-paused false
    notify-send "Mod Değişimi" "Okuma Modu Kapatıldı. Bildirimler akıyor..." -p > /tmp/dunst_id
    # Not: -p bayrağı (eğer dunst destekliyorsa) ID döndürür, işimize yarayabilir.
else
    # --- MODU AÇMA ---
    # Önce bildirimi gönderiyoruz ve ekranda kalma süresini kısıtlıyoruz (-t 1500 = 1.5 saniye)
    notify-send "Mod Değişimi" "Okuma Modu Aktif! (1.5sn sonra her yer susacak)" -t 1500 -u critical

    # Bildirimin ekranda görünmesi ve SÜRESİNİN DOLMASI için bekliyoruz.
    # Bu süre notify-send'deki -t süresinden biraz daha uzun olmalı.
    sleep 1.7

    redshift -O 2500
    touch "$FLAG_FILE"

    # Ekranda hiçbir bildirim kalmadığından emin olduktan sonra susturuyoruz.
    dunstctl set-paused true
fi
