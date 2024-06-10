#!/bin/bash

# Function to apply settings
apply_settings() {
	gsettings set org.gnome.desktop.interface gtk-theme "$2"
	gsettings set org.gnome.desktop.interface color-scheme "$3"
	gsettings set org.gnome.desktop.interface icon-theme "$4"
	export GTK_THEME="$1"

	echo "Applied theme: $1"
}

# Default values
THEME="dark"
RELAUNCH=false

# Parse command line arguments
while [[ "$#" -gt 0 ]]; do
	case $1 in
	-r | --relaunch) RELAUNCH=true ;;
	*) THEME=$1 ;;
	esac
	shift
done

# Apply the color preset if not relaunching
if [ "$THEME" == "dark" ]; then
	GTK_THEME_NAME="Adw-dark"
	ICON_THEME="Papirus-Dark"
	COLOR_SCHEME="prefer-dark"
else
	GTK_THEME_NAME="Adw"
	ICON_THEME="Papirus-Light"
	COLOR_SCHEME="prefer-light"
fi

if ! $RELAUNCH; then
	# Create gradience presets folder
	mkdir -p "$HOME/.config/presets"

	# Apply the color preset
	gradience-cli apply -p "$HOME/.colors/generated/gtk/preset.json" --gtk both
fi

apply_settings "$THEME" "$GTK_THEME_NAME" "$COLOR_SCHEME" "$ICON_THEME"
