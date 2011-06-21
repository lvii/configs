#!/bin/sh

killall dzen2 fbpanel dcompmgr
CRT=`xrandr | grep "VGA1 connected"`
if [ "x${CRT}x" != "xx" ]; then
   xrandr --output LVDS1 --off --output VGA1 --auto
fi
if [ "x${CRT}x" = "xx" ]; then
   dcompmgr --no-fade &
   xrandr --output LVDS1 --auto --output VGA1 --off
fi
setxkbmap cz
nitrogen --restore
conky -c ~/.conkyrc_dzen | dzen2 -e 'button3=' -p -fn 'terminus:size=9' -h 14 -bg '#121212' -fg '#5E5E5E' -expand left &
sleep 1 && fbpanel &
