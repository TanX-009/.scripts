#!/bin/bash

mkdir -p "$HOME/.config/presets" # create gradience presets folder
gradience-cli apply -p "$HOME/.colors/gtk/preset.json" --gtk both

gsettings set org.gnome.desktop.interface gtk-theme adw-gtk3-dark
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
