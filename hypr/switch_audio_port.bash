#!/bin/bash

# Get default sink name
default_sink=$(pactl get-default-sink)

# Get active port
active_port=$(pactl list sinks | grep -A20 'Active Port' | grep "Active Port" | awk '{print $3}')

# Define port names
rear_port="analog-output-lineout"
front_port="analog-output-headphones"

# Toggle logic
if [[ "$active_port" == "$rear_port" ]]; then
  next_port="$front_port"
else
  next_port="$rear_port"
fi

# Switch to the other port
pactl set-sink-port "$default_sink" "$next_port"
echo "Switched to port: $next_port"
