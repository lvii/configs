#!/bin/sh
#
## ~/.xinitrc
## author  : OK <ok100.ok100.ok100@gmail.com>
## website : https://github.com/ok100
#

export GTK2_RC_FILES="/home/ok/.gtkrc-2.0"
export DMENU_OPTIONS="-i -nb #121212 -nf #696969 -sb #121212 -sf #e0e0e0"

# switch to external monitor or start dcompmgr 
CRT=`xrandr | grep "VGA1 connected"`
if [ "x${CRT}x" != "xx" ]; then
   xrandr --output LVDS1 --off --output VGA1 --auto
fi
if [ "x${CRT}x" = "xx" ]; then
   dcompmgr --no-fade &
fi

# overclock cpu on demand
#sudo eeecpud -D

# lirc daemon
sudo lircd --driver=audio_alsa -d default
irexec -d
irxevent -d

# automount drives
ck-launch-session dbus-launch devmon --unmount-on-exit &

# keyboard map
setxkbmap cz

# disable CapsLock & map to Escape
setxkbmap -option caps:escape

# urxvt daemon
urxvtd -q -o -f &

# clipboard manager
parcellite &

# dropbox
dropboxd &

# mpd cover on desktop
conky -c ~/.conkyrc_mpd &

# set wallpaper
nitrogen --restore &

# dwm
exec ck-launch-session dbus-launch /home/ok/Scripts/dwm-start
