#!/bin/bash

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
CACHE_DIR="$HOME/.cache/colorinator/reload_logs/"

# Create the cache directory
mkdir -p "$CACHE_DIR"

# Initialize variables
wall=""
mode="dark"
launch=false
reload=false
relaunch=false

# Parse command-line arguments
while getopts "w:m:lrR" opt; do
	case $opt in
	w)
		wall="$OPTARG"
		;;
	m)
		mode="$OPTARG"
		;;
	l)
		launch=true
		;;
	r)
		reload=true
		;;
	R)
		relaunch=true
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

if $launch; then
	# swaybg
	if [ -n "$wall" ]; then
		"$SCRIPT_DIR"/swaybg.bash "$wall" >"$CACHE_DIR"/swaybg.log 2>&1
	fi
	# ags
	"$SCRIPT_DIR"/ags.bash -l >"$CACHE_DIR"/ags.log 2>&1
	# gradience
	if [ -n "$mode" ]; then
		"$SCRIPT_DIR"/gradience.bash "$mode" >"$CACHE_DIR"/gradience.log 2>&1
	fi
	# kvantum
	"$SCRIPT_DIR"/kvantum.bash >"$CACHE_DIR"/kvantum.log 2>&1
else
	# hyprland
	"$SCRIPT_DIR"/hyprland.bash >"$CACHE_DIR"/hyprland.log
	# terminal
	"$SCRIPT_DIR"/ptm.bash >"$CACHE_DIR"/terminal.log 2>&1

fi

if $reload; then
	# ags
	"$SCRIPT_DIR"/ags.bash -r >"$CACHE_DIR"/ags.log 2>&1
	# gradience
	if [ -n "$mode" ]; then
		"$SCRIPT_DIR"/gradience.bash "$mode" >"$CACHE_DIR"/gradience.log 2>&1
	fi
	# kvantum
	"$SCRIPT_DIR"/kvantum.bash >"$CACHE_DIR"/kvantum.log 2>&1
fi

if $relaunch; then
	# swaybg
	if [ -n "$wall" ]; then
		"$SCRIPT_DIR"/swaybg.bash "$wall" >"$CACHE_DIR"/swaybg.log 2>&1
	fi
	# ags
	"$SCRIPT_DIR"/ags.bash -R >"$CACHE_DIR"/ags.log 2>&1
	# gradience
	if [ -n "$mode" ]; then
		"$SCRIPT_DIR"/gradience.bash -r "$mode" >"$CACHE_DIR"/gradience.log 2>&1
	fi
	# kvantum
	"$SCRIPT_DIR"/kvantum.bash -r >"$CACHE_DIR"/kvantum.log 2>&1
fi
