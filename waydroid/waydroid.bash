#!/bin/bash

# Define script directory
scriptDir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

# Function to display usage
display_usage() {
	echo "Usage: $0 [start|stop|fullUI]"
	echo "Options:"
	echo "  start   : Start Waydroid session"
	echo "  stop    : Stop Waydroid session"
	echo "  fullUI  : Start Waydroid session and spawn full UI"
	exit 1
}

# Check if no arguments are provided, or if help is requested
if [[ $# -eq 0 || "$1" == "-h" || "$1" == "--help" ]]; then
	display_usage
fi

# Function to start Waydroid session
start_session() {
	if [ "$status" = "RUNNING" ]; then
		notify-send --icon="$scriptDir/waydroidIcon.png" "Waydroid session is already running!"
	elif [ "$status" = "STOPPED" ]; then
		waydroid session start &
		notify-send --icon="$scriptDir/waydroidIcon.png" "Waydroid session has started"
	fi
}

# Function to stop Waydroid session
stop_session() {
	if [ "$status" = "STOPPED" ]; then
		notify-send --icon="$scriptDir/waydroidIcon.png" "Waydroid session has stopped already!"
	elif [ "$status" = "RUNNING" ]; then
		waydroid session stop &
		notify-send --icon="$scriptDir/waydroidIcon.png" "Waydroid session has stopped"
	fi
}

# Function to spawn full UI
spawn_full_ui() {
	if [ "$status" = "RUNNING" ]; then
		waydroid show-full-ui &
		notify-send --icon="$scriptDir/waydroidIcon.png" "Spawning full UI"
	elif [ "$status" = "STOPPED" ]; then
		waydroid session start &
		waydroid show-full-ui &
		notify-send --icon="$scriptDir/waydroidIcon.png" "Waydroid session has started.
Spawning full UI"
	fi
}

# Get Waydroid session status
status=$(waydroid status | head -n 1 | sed -e 's/\(Session:[\t\ ]\)//')

# Perform action based on provided flag
case $1 in
start)
	start_session
	;;
stop)
	stop_session
	;;
fullUI)
	spawn_full_ui
	;;
*)
	echo "Invalid option: $1"
	display_usage
	;;
esac
