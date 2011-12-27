#!/bin/sh
#
## Eee PC battery monitor
## author  : OK <ok100.ok100.ok100@gmail.com>
## website : https://github.com/ok100
#

MAX_mV=7543
MIN_mV=6171
CRITBAT=20

AC=`cat /sys/class/power_supply/AC0/online`
CUR_mV=`cat /proc/acpi/battery/BAT0/state | grep mV | cut -d " " -f11`

if [ "$AC" = "1" ]; then
	echo "¡ ^fg(\#808080)\${battery_percent}%"
else
	let DIVIDER=($MAX_mV-$MIN_mV)/100
	let STATE=($CUR_mV-$MIN_mV)/$DIVIDER

	if [ $STATE -gt 100 ]; then STATE=100; fi
	if [ $STATE -lt 0 ]; then STATE=0; fi

	if [ $STATE -lt $CRITBAT ]; then
		echo "î ^fg(\#B3354C)$STATE%"
	else
		echo "ð ^fg(\#808080)$STATE%"
	fi
fi

