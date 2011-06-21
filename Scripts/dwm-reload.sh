#!/bin/sh

killall dzen2 fbpanel dwm
sleep 1 && conky -c ~/.conkyrc_dzen | dzen2 -e 'button3=' -p -fn 'terminus:size=9' -h 14 -bg '#121212' -fg '#5E5E5E' -expand left &
sleep 2 && fbpanel &
