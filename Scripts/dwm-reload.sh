#!/bin/sh

killall dzen2 fbpanel dwm
sleep 1 && conky -c ~/.conkyrc_dzen | dzen2 -e 'button3=' -p -fn 'terminus:size=8' -h 14 -bg '#121212' -fg '#696969' -expand left &
sleep 2 && fbpanel &
