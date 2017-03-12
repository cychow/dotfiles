#!/usr/bin/env bash
# source: https://www.reddit.com/r/unixporn/comments/3358vu/i3lock_unixpornworthy_lock_screen
#!/bin/bash
icon=$HOME/.config/lock.png
tempbg=/tmp/screen.png
scrot /tmp/screen.png
convert $tempbg -scale 10% -scale 1000% $tempbg
convert $tempbg $icon -gravity center -composite -matte $tempbg
i3lock -u -i $tempbg
# dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Stop
# i3lock  -I 10 -d -e -u -n -i /tmp/screen.png
#i3lock -e -u -n -i /tmp/screen.png
i3lock -n -i /tmp/screen.png
