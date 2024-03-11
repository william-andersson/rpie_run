#!/bin/bash
#
# Launch EmulationStation and keep the window maximized/active
# Requires - xdotool
#
VERSION=1.1
SESSION=$(echo $XDG_SESSION_TYPE)

exec gnome-terminal --full-screen --hide-menubar -- emulationstation &
MAIN_PID=$(echo $!)
echo "MAIN_PID: $MAIN_PID"
sleep 2

if [ "$SESSION" == "x11" ];then
	while true;do
		sleep 2
        	if ! ps $MAIN_PID >/dev/null;then
        	    if ! pidof emulationstation >/dev/null;then
        	        echo "MAIN_PID lost, exiting."
        	        exit 0
        	    else
        	        # PID will change with Alt+Tab, keep it updated.
        	        MAIN_PID=$(pidof emulationstation)
        	        echo "MAIN_PID changed: $MAIN_PID"
        	    fi
        	fi
        	# Control wayland window
		xdotool windowactivate --sync $(xdotool search --name EmulationStation) >/dev/null
	done
else
	echo "Wayland session, skip."
	exit 0
fi

kill $MAIN_PID
echo "failed"
echo "MAIN_PID: $MAIN_PID killed."
exit 1
