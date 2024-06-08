#!/bin/bash

scriptDir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
current=$(cut -f 1 -d " " <"$scriptDir/cpupower.txt")
governer=$(cut -f 2 -d " " <"$scriptDir/cpupower.txt")

if [ "$governer" = "Performance" ]; then
	cpupower-gui profile "Powersave@${current}"
	notify-send --icon="$scriptDir/fan.svg" "Powersave@${current}"
	echo "$current" "Powersave" >"$scriptDir/cpupower.txt"
elif [ "$governer" = "Powersave" ]; then
	cpupower-gui profile "Performance@${current}"
	notify-send --icon="$scriptDir/fan.svg" "Performance@${current}"
	echo "$current" "Performance" >"$scriptDir/cpupower.txt"
fi
