#!/bin/bash

# Get current volume
vol=$(pactl get-sink-volume @DEFAULT_SINK@ | awk 'NR==1{print $5}' | tr -d '%')

# Generate options 0% → 100% in steps of 5
options=""
for i in $(seq 0 5 100); do
    options+="$i%\n"
done

# Show rofi menu
selected=$(echo -e "$options" | rofi -dmenu -p "Volume" -lines 10 -no-custom -bw 2 -width 20)

# Exit if nothing selected
[[ -z "$selected" ]] && exit

# Remove % sign
selected_val=${selected%\%}

# Set volume
pactl set-sink-volume @DEFAULT_SINK@ ${selected_val}%
