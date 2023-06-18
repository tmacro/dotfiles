#!/usr/bin/env bash

is_connected() {
    xrandr | grep "^$1 connected" 2>&1 1>/dev/null
}

if is_connected "$MON_PRIMARY_DOCKED"; then
   echo "Launching docked bars..."
   bash -x $HOME/.config/polybar/launch-docked.sh
else
    echo "Launching mobile bars..."
    bash $HOME/.config/polybar/launch-mobile.sh
fi
