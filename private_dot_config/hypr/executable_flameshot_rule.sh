
#!/usr/bin/env bash

# Monitor description (from `hyprctl monitors`)
MONITOR_DESC="Dell Inc. DELL P2723DE 9L630N3"

# Windowrules depending on monitor state
RULE_WITH_MONITOR="move 0 -240, class:flameshot,title:flameshot"
RULE_NO_MONITOR="move 0 0, class:flameshot,title:flameshot"


apply_rule() {
    local rule="$1"
    echo "Applying windowrule: $rule"
    hyprctl keyword windowrule "$rule"
}

check_monitors() {
    if hyprctl monitors | grep "$MONITOR_DESC"; then
        apply_rule "$RULE_WITH_MONITOR"
    else
        apply_rule "$RULE_NO_MONITOR"
    fi
}

# Initial check on startup
check_monitors
SOCKET=$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock
# Listen for Hyprland monitor events
# Also trigger when reloading the config, so that it's set correctly every time
socat -U - UNIX-CONNECT:"$SOCKET" | grep --line-buffered "monitoraddedv2\|monitorremovedv2\|configureloaded" | while read -r line; do check_monitors ; done
