#!/bin/bash
#
# Launch EmulationStation and keep the window maximized/active
#
# Copyright:   William Andersson 2024
# Website:     https://github.com/william-andersson
# License:     GPL
#
# Requires - xdotool
VERSION=1.0

exec gnome-terminal --full-screen --hide-menubar -- emulationstation &
MAIN_PID=$(echo $!)
echo "MAIN_PID: $MAIN_PID"
sleep 2

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

kill $MAIN_PID
echo "failed"
echo "MAIN_PID: $MAIN_PID killed."
exit 1
