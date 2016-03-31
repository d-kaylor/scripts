#!/bin/bash

# VPN connection as listed in NetworkManager
VPN_CONNECTION="Phoenix - OpenVPN TCP"

# Number of seconds to wait between checks
NORMAL_INTERVAL=60

# Number of seconds to wait after a failure. Set a longer interval to keep this script from spamming your notification area
FAIL_INTERVAL=1800

# Sound to play when a failure occurs
ALERT_SOUND=/usr/share/sounds/gnome/default/alerts/drip.ogg

while true; do
    ACTIVE_CON=$(nmcli connection show --active)
    if [[ $? -eq 0 && $ACTIVE_CON != *$VPN_CONNECTION* ]]; then
        if [ -n "$ALERT_SOUND" ]; then
            play -q $ALERT_SOUND
        fi
        notify-send "VPN is down" "Your VPN is down" -i dialog-error
        sleep $FAIL_INTERVAL
    else
        sleep $NORMAL_INTERVAL
    fi
done
