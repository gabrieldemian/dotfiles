#!/bin/sh

xset r rate 200 50
exec picom --config /home/gabriel/.config/picom/picom.conf &
~/.fehbg &
# exec fastcompmgr -o 1 -r 12
xrdb -merge ~/.Xresources
xrdb -merge ~/.colors
exec bspwm
