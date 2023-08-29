#!/bin/bash

# Terminate already running bar instances
killall -q polybar

# Launch Polybar
polybar --config=~/.config/polybar/config.ini marco 2>&1 | tee -a /tmp/polybar.log & disown

xrandr --auto && xrandr --output eDP-1 --off

echo 'Polybar launched...'
