#!/bin/sh
#
## ~/.xinitrc
## author  : OK <ok100.ok100.ok100@gmail.com>
## website : https://github.com/ok100
#

export GTK2_RC_FILES="/home/ok/.gtkrc-2.0"
export MOZ_DISABLE_PANGO=1
export OPERAPLUGINWRAPPER_PRIORITY=0
export OPERA_KEEP_BLOCKED_PLUGIN=1
export GDK_NATIVE_WINDOWS=1

xrdb .Xdefaults

# switch to external monitor or start xcompmgr 
CRT=`xrandr | grep "VGA1 connected"`
if [ "x${CRT}x" != "xx" ]; then
   xrandr --output LVDS1 --off --output VGA1 --auto
fi
if [ "x${CRT}x" = "xx" ]; then
   xcalib ~/.icc/eeePC.icc
   xcompmgr -a &
fi

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

# wallpaper
nitrogen --restore &

# dwm
exec ck-launch-session dbus-launch /home/ok/Scripts/dwm-start
