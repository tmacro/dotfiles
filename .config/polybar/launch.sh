#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch bar1 and bar2
MONITOR="$MON_PRIMARY" polybar main-left &
MONITOR="$MON_PRIMARY" polybar main-right &
MONITOR="$MON_PRIMARY" polybar tray &

if [ -n "$MON_SECONDARY" ]; then
MONITOR="$MON_SECONDARY" polybar secondary-left &
fi

echo "Bars launched..."
