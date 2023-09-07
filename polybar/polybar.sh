#!/bin/bash

# Terminate already running bar instances
killall -q polybar

# Launch Polybar
# polybar --config=~/.config/polybar/config.ini marco 2>&1 | tee -a /tmp/polybar.log & disown

while pgrep -u $UID -x polybar > /dev/null; do sleep 1; done

polybar monitor1 &
polybar monitor2 &

echo 'Polybar launched...'
