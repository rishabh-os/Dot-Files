#!/bin/sh

TOGGLE_FILE="/tmp/hypr-blur-off"

if [ -f "$TOGGLE_FILE" ]; then
    hyprctl keyword 'windowrule[blur_windows]:enable true'
    hyprctl keyword 'layerrule[blur_layers]:enable false'
    hyprctl keyword decoration:blur:enabled true
    rm "$TOGGLE_FILE"
else
    hyprctl keyword 'windowrule[blur_windows]:enable false'
    hyprctl keyword 'layerrule[blur_layers]:enable true'
    hyprctl keyword decoration:blur:enabled false
    touch "$TOGGLE_FILE"
fi
