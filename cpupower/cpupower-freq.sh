#!/bin/bash

scriptDir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
current=$(cut -f 1 -d " " <"$scriptDir/cpupower.txt")
governer=$(cut -f 2 -d " " <"$scriptDir/cpupower.txt")

if [ "$current" = "4.1GHz" ]; then
	cpupower-gui profile "${governer}@1.0GHz"
	echo "1.0GHz" "$governer" >"$scriptDir/cpupower.txt"
	notify-send --icon="$scriptDir/fan.svg" "${governer}@1.0GHz"
elif [ "$current" = "1.0GHz" ]; then
	cpupower-gui profile "${governer}@2.4GHz"
	echo "2.4GHz" "$governer" >"$scriptDir/cpupower.txt"
	notify-send --icon="$scriptDir/fan.svg" "${governer}@2.4GHz"
elif [ "$current" = "2.4GHz" ]; then
	cpupower-gui profile "${governer}@3.0GHz"
	echo "3.0GHz" "$governer" >"$scriptDir/cpupower.txt"
	notify-send --icon="$scriptDir/fan.svg" "${governer}@3.0GHz"
elif [ "$current" = "3.0GHz" ]; then
	cpupower-gui profile "${governer}@4.1GHz"
	echo "4.1GHz" "$governer" >"$scriptDir/cpupower.txt"
	notify-send --icon="$scriptDir/fan.svg" "${governer}@4.1GHz"
fi
