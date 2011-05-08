#!/bin/sh

AC=$(cat /sys/class/power_supply/AC0/online)
STATEFILE='/proc/acpi/battery/BAT0/state'
INFOFILE='/proc/acpi/battery/BAT0/info'
LOWBAT=35
CRITBAT=15
BAT_FULL=`cat $INFOFILE|grep design|line|cut -d " " -f 11`
RCAP=`cat $STATEFILE|grep remaining|cut -d " " -f 8`
RPERCT=`expr $RCAP \* 100`
RPERC=`expr $RPERCT / $BAT_FULL`

if [ "$AC" = "1" ]; then
	echo '^i(/home/ok/.dzen/icons/ac_01.xbm) ^fg(\#477AB3)AC^fg()'
else
	if [ $RPERC -le $LOWBAT ]; then
		if [ $RPERC -le $CRITBAT ]; then
			echo '^fg(\#BF4D80)^i(/home/ok/.dzen/icons/bat_empty_02.xbm) ${battery_percent}^fg()'
		else
			echo '^fg(\#A270A3)^i(/home/ok/.dzen/icons/bat_low_02.xbm) ${battery_percent}^fg()'
		fi
	else
		echo '^i(/home/ok/.dzen/icons/bat_full_02.xbm) ^fg(\#519C7D)${battery_percent}^fg()'
	fi
fi
