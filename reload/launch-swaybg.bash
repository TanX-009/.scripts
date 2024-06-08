#!/bin/bash

RECORD_FILE="$HOME/.colors/record"

killall swaybg

if [ -f "$RECORD_FILE" ]; then
	IFS='|' read -r prev_mode wallpaper <"$RECORD_FILE"
else
	prev_mode=""
fi

if [[ "$1" == "-o" ]]; then
	if [ -z "$wallpaper" ]; then
		echo "Old record not found!"
		exit 0
	fi
else
	wallpaper="$1"
	echo "$prev_mode|$wallpaper" >"$RECORD_FILE"
fi

swaybg -m fill -i "$wallpaper" &
