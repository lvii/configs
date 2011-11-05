#!/bin/sh
#
## Eee PC battery monitor
## author  : OK <ok100.ok100.ok100@gmail.com>
## website : https://github.com/ok100
#

BAT_MAX_mV=7543
BAT_MIN_mV=6171
AC_MAX_mV=8226
AC_MIN_mV=7935
LOWBAT=30
CRITBAT=15

AC=`cat /sys/class/power_supply/AC0/online`
CUR_mV=`cat /proc/acpi/battery/BAT0/state | grep mV | cut -d " " -f11`

if [ "$AC" = "1" ]; then
    let DIVIDER=($AC_MAX_mV-$AC_MIN_mV)/100
    let STATE=($CUR_mV-$AC_MIN_mV)/$DIVIDER

    if [ $STATE -gt 100 ]; then STATE=100; fi
    if [ $STATE -lt 0 ]; then STATE=0; fi

	echo '^fg(\#738080)AC ^fg(\#3995BF)'$STATE'%^fg()'
else
    let DIVIDER=($BAT_MAX_mV-$BAT_MIN_mV)/100
    let STATE=($CUR_mV-$BAT_MIN_mV)/$DIVIDER

    if [ $STATE -gt 100 ]; then STATE=100; fi
    if [ $STATE -lt 0 ]; then STATE=0; fi

	if [ $STATE -le $LOWBAT ]; then
		if [ $STATE -le $CRITBAT ]; then
			echo '^fg(\#738080)BAT ^fg(\#B3354C)'$STATE'%^fg()'
		else
			echo '^fg(\#738080)BAT ^fg(\#A64286)'$STATE'%^fg()'
		fi
	else
		echo '^fg(\#738080)BAT ^fg(\#3995BF)'$STATE'%^fg()'
	fi
fi

