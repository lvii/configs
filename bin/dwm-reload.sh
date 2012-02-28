#!/bin/sh

killall dzen2 fbpanel dwm conky
sleep 1 && conky -c ~/.conkyrc_dzen | dzen2 -e 'button3=' -p -expand left &>/dev/null &
sleep 1 && conky -c ~/.conky/conkyrc &
sleep 2 && fbpanel &
