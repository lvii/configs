#!/bin/sh
#
## battery widget for use with dzen2 + conky
## author  : OK <ok100.ok100.ok100@gmail.com>
## website : https://github.com/ok100
#

AC=$(cat /sys/class/power_supply/AC0/online)
STATE=$(acpi -b | cut -d " " -f4 | cut -d "%" -f1)
LOWBAT=35
CRITBAT=15

if [ "$AC" = "1" ]; then
	echo '^fg(\#477AB3)AC^fg()'
else
	if [ $STATE -le $LOWBAT ]; then
		if [ $STATE -le $CRITBAT ]; then
			echo '^fg(\#BF4D80)${battery_percent}%^fg()'
		else
			echo '^fg(\#A270A3)${battery_percent}%^fg()'
		fi
	else
		echo '^fg(\#519C7D)${battery_percent}%^fg()'
	fi
fi
