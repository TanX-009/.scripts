#!/bin/bash

hyprctl keyword animations:enabled 0
hyprctl keyword decoration:blur:enabled 0
hyprctl keyword monitor eDP-1 ,1920x1080@60,0x0,1

asusctl profile -P Quiet
brightnessctl -sd asus::kbd_backlight set 0
brightnessctl -s set 10%
