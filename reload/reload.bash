#!/bin/bash

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
CACHE_DIR="$HOME/.cache/colorinator/reload_logs/"

# create the cache directory
mkdir -p "$CACHE_DIR"

# Initialize variables
wall=""
mode="dark"

# Parse command-line arguments
while getopts "w:m:" opt; do
	case $opt in
	w)
		wall="$OPTARG"
		;;
	m)
		mode="$OPTARG"
		;;
	\?)
		echo "Invalid option -$OPTARG" >&2
		exit 1
		;;
	esac
done

"$SCRIPT_DIR"/launch-waybar.bash >"$CACHE_DIR"/waybar.log 2>&1

if [ -n "$wall" ]; then
	"$SCRIPT_DIR"/launch-swaybg.bash "$wall" >"$CACHE_DIR"/swaybg.log 2>&1
fi

"$SCRIPT_DIR"/apply-ptm.bash >"$CACHE_DIR"/terminal.log 2>&1
"$SCRIPT_DIR"/apply-swaync.bash >"$CACHE_DIR"/swaync.log 2>&1

if [ -n "$mode" ]; then
	"$SCRIPT_DIR"/apply-gradience.bash "$mode" >"$CACHE_DIR"/gradience.log 2>&1
fi

"$SCRIPT_DIR"/apply-kvantum.bash >"$CACHE_DIR"/kvantum.log 2>&1
