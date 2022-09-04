#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch bar1 and bar2
MONITOR=DisplayPort-3 polybar main-left &
MONITOR=HDMI-A-1 polybar secondary-left &
MONITOR=DisplayPort-3 polybar main-right &
MONITOR=DisplayPort-3 polybar tray &
#polybar bar2 &

echo "Bars launched..."
