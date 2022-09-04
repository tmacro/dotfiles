#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

MONITOR="$MON_PRIMARY_DOCKED" polybar main-left &
MONITOR="$MON_PRIMARY_DOCKED" polybar main-right &
MONITOR="$MON_PRIMARY_DOCKED" polybar tray &

if [ -n "$MON_SECONDARY_DOCKED" ]; then
    MONITOR="$MON_SECONDARY_DOCKED" polybar secondary-left &
fi

echo "Bars launched..."
