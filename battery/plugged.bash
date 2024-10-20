#!/bin/bash

hyprctl keyword animations:enabled 1
hyprctl keyword decoration:blur:enabled 1
hyprctl keyword monitor eDP-1 ,1920x1080@144,0x0,1

asusctl profile -P Balanced
brightnessctl -rd asus::kbd_backlight
brightnessctl -r
