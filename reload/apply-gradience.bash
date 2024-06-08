#!/bin/bash

# Check if an argument is passed, otherwise default to "dark"
THEME=${1:-dark}

# Set the appropriate GTK theme based on the passed argument
if [ "$THEME" == "dark" ]; then
	GTK_THEME_NAME="Adw-dark"
	ICON_THEME="Papirus-Dark"
	COLOR_SCHEME="prefer-dark"
else
	GTK_THEME_NAME="Adw"
	ICON_THEME="Papirus-Light"
	COLOR_SCHEME="prefer-light"
fi

# Create gradience presets folder
mkdir -p "$HOME/.config/presets"

# Apply the color preset
gradience-cli apply -p "$HOME/.colors/gtk/preset.json" --gtk both

# Set GTK theme, color scheme, and icon theme
gsettings set org.gnome.desktop.interface gtk-theme "$GTK_THEME_NAME"
gsettings set org.gnome.desktop.interface color-scheme "$COLOR_SCHEME"
gsettings set org.gnome.desktop.interface icon-theme "$ICON_THEME"

# Export GTK_THEME environment variable
export GTK_THEME="$GTK_THEME_NAME"

echo "Applied theme: $THEME"
