#!/bin/bash

killall swaybg

swaybg -m fill -i "$1" &
