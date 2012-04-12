#!/bin/sh
#
## ~/.xinitrc
## author  : OK <ok100.ok100.ok100@gmail.com>
## website : https://github.com/ok100
#

xrdb ~/.Xresources

# switch to external monitor or start xcompmgr 
CRT=`xrandr | grep "VGA1 connected"`
if [ "x${CRT}x" != "xx" ]; then
   xrandr --output LVDS1 --off --output VGA1 --auto
fi
if [ "x${CRT}x" = "xx" ]; then
   xcalib ~/.icc/eeePC.icc
   xcompmgr -a &
fi

# keyboard map
setxkbmap cz

# disable CapsLock & map to Escape
setxkbmap -option caps:escape

# urxvt daemon
urxvtd -q -o -f &

# clipboard manager
parcellite -n &

# dropbox
dropboxd &

# wallpaper
eval $(cat ~/.fehbg)

# lirc
irexec &

# hide cursor
unclutter -noevents &

# weather
#conky -c ~/.conky/conkyrc &

# dwm
exec dbus-launch /home/ok/bin/dwm-start

# monsterwm
#exec dbus-launch /home/ok/bin/monsterwm-start
