#!/bin/bash

# Get a list of available sinks
sinks=($(pactl list short sinks | awk '{print $1}'))

if [[ ${#sinks[@]} -lt 2 ]]; then
  echo "At least two audio outputs are required to toggle!"
  exit 1
fi

current_sink_name=$(pactl get-default-sink)
current_sink_id=$(pactl list short sinks | grep "$current_sink_name" | awk '{print $1}')

# Determine the next sink to switch to
next_sink=""
for i in "${!sinks[@]}"; do
  if [[ "${sinks[i]}" == "$current_sink_id" ]]; then
    next_sink=${sinks[((i + 1) % ${#sinks[@]})]}
    break
  fi
done
echo $next_sink

# If no match found, default to the first sink
if [[ -z $next_sink ]]; then
  next_sink=${sinks[0]}
fi

# Set the new default sink
pactl set-default-sink "$next_sink"

echo "Switched audio output to sink: $next_sink"
