#!/usr/bin/env bash

is_connected() {
    xrandr | grep "^$1 connected" 2>&1 1>/dev/null
}

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

MONITOR="$MON_PRIMARY" polybar -c ~/.config/polybar/config.ini laptop-mobile &

if is_connected "$MON_SECONDARY"; then
    MONITOR="$MON_SECONDARY" polybar -c ~/.config/polybar/config.ini secondary-mobile  &
fi

echo "Bars launched..."
