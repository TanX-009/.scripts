#!/bin/bash

reload=false
launch=false

usage() {
  echo "Usage: $0 {-r | -l}"
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
*)
  usage
  ;;
esac

if $launch; then
  ags &
elif $reload; then
  killall ags
  ags &
fi
