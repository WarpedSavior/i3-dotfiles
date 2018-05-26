#!/bin/bash

# apparently, 'active' is language dependant, so if it doesn't work
# for you, maybo you have to change 'sí' for 'yes' or something
# similar to the next line:
# nmcli -t -f active,ssid dev wifi | egrep '^yes' | cut -d\' -f2

ssid=$(nmcli -t -f active,ssid dev wifi | egrep '^sí' | cut -c 5-)
signal=$(nmcli -t -f active,signal dev wifi | egrep '^sí' | cut -c 5-)

if [ -z "$ssid" ]; then
    echo "Not connected"
else
    echo "$ssid($signal%)"
fi
