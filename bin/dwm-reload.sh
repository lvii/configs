#!/bin/sh

killall dzen2 fbpanel dwm
sleep 1 && conky -c ~/.conkyrc_dzen | dzen2 -e 'button3=' -p -expand left &
sleep 2 && fbpanel &