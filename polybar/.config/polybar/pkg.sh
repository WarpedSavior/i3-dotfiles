#!/bin/bash
pac=$(checkupdates 2> /dev/null | wc -l)
aur=$(trizen -Su --aur --quiet | wc -l)

echo "$pac%{F#689d6a}%{F-}$aur"
; 
