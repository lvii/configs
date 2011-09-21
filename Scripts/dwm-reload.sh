#!/bin/sh

killall dzen2 fbpanel dwm
sleep 1 && conky -c ~/.conkyrc_dzen | dzen2 -e 'button3=' -p -fn 'terminus:size=9' -h 14 -bg '#002b36' -fg '#657b83' -expand left &
sleep 2 && fbpanel &
