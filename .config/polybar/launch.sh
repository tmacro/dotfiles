#!/usr/bin/env bash

connected_mon="$(xrandr | grep -c '\sconnected')"

if [ "$connected_mon" == "1" ]; then
    echo "Launching mobile bars..."
    bash $HOME/.config/polybar/launch-mobile.sh
else
    echo "Launching docked bars..."
    bash $HOME/.config/polybar/launch-docked.sh
fi
