#!/bin/sh

killall dzen2 fbpanel dwm
sleep 1 && conky -c ~/.conkyrc_dzen | dzen2 -e 'button3=' -p -fn 'arial:bold:size=9' -h 16 -bg '#121212' -fg '#696969' -expand left &
sleep 2 && fbpanel &
