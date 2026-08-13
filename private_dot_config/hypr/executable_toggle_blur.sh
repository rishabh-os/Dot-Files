#!/bin/sh

TOGGLE_FILE="/tmp/hypr-blur-off"

if [ -f "$TOGGLE_FILE" ]; then
	hyprctl eval "blur_windows_rule:set_enabled(true)"
	hyprctl eval "blur_layers_rule:set_enabled(true)"
	hyprctl eval "hl.config({ decoration = { blur = { enabled = true } } })"
	rm "$TOGGLE_FILE"
else
	hyprctl eval "blur_windows_rule:set_enabled(false)"
	hyprctl eval "blur_layers_rule:set_enabled(false)"
	hyprctl eval "hl.config({ decoration = { blur = { enabled = false } } })"
	touch "$TOGGLE_FILE"
fi
