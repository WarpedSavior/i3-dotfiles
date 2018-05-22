#!/bin/bash

# note: if it doesn't work, change 'sí' for 'yes' or
# equivalent to your language, and the cut part

# nmcli -t -f active,ssid dev wifi | egrep '^yes' | cut -d\' -f2
ssid=$(nmcli -t -f active,ssid dev wifi | egrep '^sí' | cut -c 5-)

if [ -z "$ssid" ]; then
    echo "Not connected"
else
    echo "$ssid"
fi
