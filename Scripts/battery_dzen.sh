#!/bin/sh
#
## Eee PC battery monitor
## author  : OK <ok100.ok100.ok100@gmail.com>
## website : https://github.com/ok100
#

BAT_MAX_mV=7716
BAT_MIN_mV=6171
AC_MAX_mV=8226
AC_MIN_mV=7771
LOWBAT=30
CRITBAT=15

AC=`cat /sys/class/power_supply/AC0/online`
CUR_mV=`cat /proc/acpi/battery/BAT0/state | grep mV | cut -d " " -f11`

if [ "$AC" = "1" ]; then
    let DIVIDER=($AC_MAX_mV-$AC_MIN_mV)/100
    let STATE=($CUR_mV-$AC_MIN_mV)/$DIVIDER

    if [ $STATE -gt 100 ]; then STATE=100; fi
    if [ $STATE -lt 0 ]; then STATE=0; fi

	echo '^i(/home/ok/.dzen/icons/ac_01.xbm) ^fg(\#268bd2)'$STATE'^fg()'
else
    let DIVIDER=($BAT_MAX_mV-$BAT_MIN_mV)/100
    let STATE=($CUR_mV-$BAT_MIN_mV)/$DIVIDER

    if [ $STATE -gt 100 ]; then STATE=100; fi
    if [ $STATE -lt 0 ]; then STATE=0; fi

	if [ $STATE -le $LOWBAT ]; then
		if [ $STATE -le $CRITBAT ]; then
			echo '^i(/home/ok/.dzen/icons/bat_empty_01.xbm) ^fg(\#dc322f)'$STATE'^fg()'
		else
			echo '^i(/home/ok/.dzen/icons/bat_low_01.xbm) ^fg(\#d33682)'$STATE'^fg()'
		fi
	else
		echo '^i(/home/ok/.dzen/icons/bat_full_01.xbm) ^fg(\#268bd2)'$STATE'^fg()'
	fi
fi

