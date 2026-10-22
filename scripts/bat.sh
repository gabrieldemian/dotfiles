#!/bin/bash

FLAG=/tmp/low_bat_notf

while true; do
	curr=$(cat /sys/class/power_supply/BAT0/energy_now)
	total=$(cat /sys/class/power_supply/BAT0/energy_full)
	per=$(awk "BEGIN {printf \"%.f\",${curr}/${total}*100}")
	batstatus=$(cat /sys/class/power_supply/BAT0/status)
	if [ "$batstatus" == "Discharging" ]; then
		if [ $per -lt 20 ]; then
			if [ ! -e "$FLAG" ]; then
				notify-send "low battery (⇀‸↼‶)" -u critical
				>"$FLAG"
			fi
		fi
	fi
	if [ "$batstatus" != "Discharging" ] || [ $per -ge 20 ]; then
		rm -f "$FLAG"
	fi
	sleep 10
done
