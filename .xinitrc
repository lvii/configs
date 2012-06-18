#!/bin/sh
#
## ~/.xinitrc
## author  : OK100 <ok100.ok100.ok100@gmail.com>
## website : https://github.com/ok100
#

# read Xresources
xrdb ~/.Xresources

# switch to external monitor if connected
CRT=`xrandr | grep "VGA1 connected"`
if [ "x${CRT}x" != "xx" ]; then
   xrandr --output LVDS1 --off --output VGA1 --auto
fi
if [ "x${CRT}x" = "xx" ]; then
   xcalib ~/.icc/eeePC.icc
fi

# redshift
redshift -l 48.346438:19.150887 -b 0.9 &

# xcompmgr
xcompmgr -a &

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
irxevent &

# hide cursor
unclutter -noevents &

# weather
#conky -c ~/.conky/conkyrc &

# dwm
exec dbus-launch /home/ok/bin/dwm-start
#exec dbus-launch spectrwm

# monsterwm
#exec dbus-launch /home/ok/bin/monsterwm-start
