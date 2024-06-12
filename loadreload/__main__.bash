#!/bin/bash

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
CACHE_DIR="$HOME/.cache/colorinator/reload_logs/"

# Create the cache directory
mkdir -p "$CACHE_DIR"

# Initialize variables
wall=""
mode="dark"
launch_only=false

# Parse command-line arguments
while getopts "w:m:l" opt; do
	case $opt in
	w)
		wall="$OPTARG"
		;;
	m)
		mode="$OPTARG"
		;;
	l)
		launch_only=true
		;;
	\?)
		echo "Invalid option -$OPTARG" >&2
		exit 1
		;;
	esac
done

# if launch then only apply kvantum, gradience and
# start ags, swaybg don't generate anything
# else generate and apply

# ags
"$SCRIPT_DIR"/ags.bash >"$CACHE_DIR"/ags.log 2>&1
# swaybg
if [ -n "$wall" ]; then
	"$SCRIPT_DIR"/swaybg.bash "$wall" >"$CACHE_DIR"/swaybg.log 2>&1
fi

if $launch_only; then
	# gradience
	if [ -n "$mode" ]; then
		"$SCRIPT_DIR"/gradience.bash -r "$mode" >"$CACHE_DIR"/gradience.log 2>&1
	fi
	# kvantum
	"$SCRIPT_DIR"/kvantum.bash -r >"$CACHE_DIR"/kvantum.log 2>&1
else
	# swaync
	# "$SCRIPT_DIR"/swaync.bash >"$CACHE_DIR"/swaync.log 2>&1
	# terminal
	"$SCRIPT_DIR"/ptm.bash >"$CACHE_DIR"/terminal.log 2>&1
	# gradience
	if [ -n "$mode" ]; then
		"$SCRIPT_DIR"/gradience.bash "$mode" >"$CACHE_DIR"/gradience.log 2>&1
	fi
	# kvantum
	"$SCRIPT_DIR"/kvantum.bash >"$CACHE_DIR"/kvantum.log 2>&1
fi
