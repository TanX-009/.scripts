#!/bin/bash

# Function to set Kvantum theme
set_kvantum_theme() {
	if [[ -x $(command -v kvantummanager) ]]; then
		kvantummanager --set Colorinator
	else
		echo "Kvantum Manager not installed!"
	fi
}

# Default value
RELAUNCH=false

# Parse command line arguments
while [[ "$#" -gt 0 ]]; do
	case $1 in
	-r | --relaunch) RELAUNCH=true ;;
	esac
	shift
done

if ! $RELAUNCH; then
	# Create kvantum theme folder
	mkdir -p "$HOME/.config/Kvantum/Colorinator"

	cp "$HOME/.colors/generated/kvantum/template.svg" "$HOME/.config/Kvantum/Colorinator/Colorinator.svg"
	cp "$HOME/.colors/generated/kvantum/template.kvconfig" "$HOME/.config/Kvantum/Colorinator/Colorinator.kvconfig"

fi

set_kvantum_theme
