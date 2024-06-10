#!/bin/bash

if pidof swaync-client; then
	swaync-client --reload-config &
	swaync-client --reload-css &
fi
