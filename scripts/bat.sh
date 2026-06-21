#!/bin/bash

while true; do
	curr=$(cat /sys/class/power_supply/BAT0/energy_now)
	total=$(cat /sys/class/power_supply/BAT0/energy_full)
	per=$(awk "BEGIN {printf \"%.f\",${curr}/${total}*100}")
	batstatus=$(cat /sys/class/power_supply/BAT0/status)
	if [ "$batstatus" == "Discharging" ]; then
		if [ $per -lt 25 ]; then
			notify-send "low battery (⇀‸↼‶)" -u critical
		fi
	fi
	sleep 5
done
