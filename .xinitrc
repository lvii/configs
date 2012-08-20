#!/bin/sh
#
## ~/.xinitrc
## author  : OK100 <ok100@lavabit.com>
## website : https://github.com/ok100
#

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# read Xresources
xrdb ~/.Xresources

# switch to external monitor if connected
CRT=$(xrandr | grep "VGA1 connected")
if [ -n "$CRT" ]; then
   xrandr --output LVDS1 --off --output VGA1 --auto
fi

# redshift
redshift -l 48.736507:19.14623 -b 0.9 &

# compton
compton &

# keyboard map
setxkbmap cz

# disable CapsLock & map to Escape
setxkbmap -option caps:escape

# urxvt daemon
urxvtd -q -o -f &

# clipboard manager
loliclip --daemon

# dropbox
dropboxd &

# wallpaper
eval $(cat ~/.fehbg)

# lirc
irexec &
irxevent &

# hide cursor
unclutter -noevents &

# start dwm
exec /home/ok/bin/dwm-start
