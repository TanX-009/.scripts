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

THEME=$1

# Apply the color preset if not relaunching
if [ "$THEME" == "dark" ]; then
  GTK_THEME_NAME="adw-gtk3-dark"
  ICON_THEME="Papirus-Dark"
  COLOR_SCHEME="prefer-dark"
else
  GTK_THEME_NAME="adw-gtk3"
  ICON_THEME="Papirus-Light"
  COLOR_SCHEME="prefer-light"
fi

apply_settings "$THEME" "$GTK_THEME_NAME" "$COLOR_SCHEME" "$ICON_THEME"
