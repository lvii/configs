#!/bin/sh

MAX_mV=7900
MIN_mV=6171
CRITBAT=20

CUR_mV=`cat /proc/acpi/battery/BAT0/state | grep mV | cut -d " " -f11`

let DIVIDER=($MAX_mV-$MIN_mV)/100
let STATE=($CUR_mV-$MIN_mV)/$DIVIDER

if [ $STATE -gt 100 ]; then STATE=100; fi
if [ $STATE -lt 0 ]; then STATE=0; fi

if [ $STATE -lt $CRITBAT ]; then
	echo "î ^fg(\#B3354C)$STATE%"
else
	echo "ð ^fg(\#808080)$STATE%"
fi
