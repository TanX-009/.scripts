#!/bin/bash

reload=false
launch=false
relaunch=false

usage() {
	echo "Usage: $0 {-r | -l | -R}"
	exit 1
}

if [ "$#" -ne 1 ]; then
	usage
fi

case $1 in
-r)
	echo "Reloading..."
	reload=true
	;;
-l)
	echo "Launching..."
	launch=true
	;;
-R)
	echo "Relaunching..."
	relaunch=true
	;;
*)
	usage
	;;
esac

if $reload; then
	ags run-js "handleStyles(false);"
	ags run-js 'openColorScheme.value = true; Utils.timeout(2000, () => openColorScheme.value = false);'
elif $launch; then
	ags &
elif $relaunch; then
	killall ags ydotool
	ags &
fi
