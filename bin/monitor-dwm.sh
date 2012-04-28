#!/bin/sh

CRT=`xrandr | grep "VGA1 connected"`

if [ "x${CRT}x" != "xx" ]; then
   xrandr --output LVDS1 --off --output VGA1 --auto
fi
if [ "x${CRT}x" = "xx" ]; then
   xcalib ~/.icc/eeePC.icc
   xrandr --output LVDS1 --auto --output VGA1 --off
fi

setxkbmap cz
gempaper set &
