#!/bin/sh

xrdb -merge ~/.Xresources
xrdb -merge ~/.colors
~/.fehbg &
eww open bar &
xset r rate 200 50
# exec fastcompmgr -o 1 -r 12
exec picom --config /home/gabriel/.config/picom/picom.conf &
xsetroot -cursor_name left_ptr
exec bspwm
