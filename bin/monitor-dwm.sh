#!/bin/sh

killall dzen2 fbpanel dcompmgr
CRT=`xrandr | grep "VGA1 connected"`
if [ "x${CRT}x" != "xx" ]; then
   xrandr --output LVDS1 --off --output VGA1 --auto
fi
if [ "x${CRT}x" = "xx" ]; then
   xcompmgr -a &
   xcalib ~/.icc/eeePC.icc
   xrandr --output LVDS1 --auto --output VGA1 --off
fi
killall dwm
setxkbmap cz
nitrogen --restore
conky -c ~/.conkyrc_dzen | dzen2 -e 'button3=' -p -expand left &>/dev/null &
sleep 1 && fbpanel &
