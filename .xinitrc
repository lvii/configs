#!/bin/sh
#
## ~/.xinitrc
## author  : OK100 <ok100@lavabit.com>
## website : https://github.com/ok100
#

# switch to external monitor if connected
CRT=$(xrandr | grep "VGA1 connected")
if [ -n "$CRT" ]; then
   xrandr --output LVDS1 --off --output VGA1 --auto
fi

# read Xresources
xrdb ~/.Xresources

# redshift
redshift -l 48.736507:19.14623 -b 0.9 &

# screen compositor
compton --vsync opengl &

# set keyboard map, disable CapsLock & map to Escape
setxkbmap cz -option caps:escape

# urxvt daemon
urxvtd -q -o -f &

# clipboard manager
loliclip --daemon

# mpd
mpd
pidof mpdscribble >& /dev/null
if [ $? -ne 0 ]; then
	mpdscribble &
fi

# lirc
irexec &
irxevent &

# hide cursor
unclutter -noevents &

# start tmux
urxvtc -e tmux -2 attach &

# set wallpaper
eval $(cat ~/.fehbg)

# start dwm
exec dbus-launch /home/ok/bin/dwm-start
