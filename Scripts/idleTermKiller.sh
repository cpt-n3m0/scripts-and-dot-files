#!/bin/bash

TERM_WINDOW_ID=$(xdotool getactivewindow)
latestInteraction=$(date +%s)
MAXTERMIDLETIME=180 

while [[ 1 == 1 ]]; do
	pcs=$(ps -o cmd  | grep -vE "bash|ps|idleTermKiller|CMD|sleep" | wc -l)
	bash=$(ps -o pid,cmd | grep -vE "ps|idleTermKiller|CMD" | head -n1 | awk '{ printf $1 }')
	isActive=$(( $TERM_WINDOW_ID ==  $(xdotool getactivewindow) ))

	if [ $pcs -gt 1 ] || [ $isActive -eq 1 ]; then
		latestInteraction=$(date +%s)
	elif  [ $(( $(date +%s) - $latestInteraction )) -gt $MAXTERMIDLETIME ]; then
		echo "exiting $PPID"
		kill -9 $PPID
	fi
	
	sleep 0.5
done
