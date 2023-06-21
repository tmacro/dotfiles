#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

MONITOR="$MON_PRIMARY_DOCKED" polybar primary -c ~/.config/polybar/config.ini &

if [ -n "$MON_SECONDARY_DOCKED" ]; then
    MONITOR="$MON_SECONDARY_DOCKED" polybar -c ~/.config/polybar/config.ini secondary &
fi

if [ -n "$MON_BUILTIN" ]; then
    MONITOR="$MON_BUILTIN" polybar -c ~/.config/polybar/config.ini laptop-docked &
fi

echo "Bars launched..."
