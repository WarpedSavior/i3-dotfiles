#!/bin/bash

# this script gets the current wallpaper
# and updates betterlockscreen cache

# please create blurred images beforehand
# using betterlockscreen for example
# and put them in ~/Pictures/cache/
# with the same name as the wallpapers

# assuming feh is used
# assuming also that wallpapers are in ~/Pictures/random/

# gets the name of the current wallpaper
wallpaper=$(awk -F"random/" '{print $2}' ~/.fehbg | awk -F" " '{print $1}' | rev | cut -c 2- | rev)

mkdir -p ~/.cache/i3lock
rm -f ~/.cache/i3lock/*
cd ~/Pictures/cache
cp $wallpaper ~/.cache/i3lock/
cd ~/.cache/i3lock
mv $wallpaper l_blur.png

# betterlockscreen -u $wallpaper -b 1
