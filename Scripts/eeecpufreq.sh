#!/bin/sh
#
## eeecpufreq.sh
## author  : OK <ok100.ok100.ok100@gmail.com>
## website : https://github.com/ok100
#

let CPU_FREQ=`cat /proc/eee/fsb | cut -d " " -f1`*9
if [ $CPU_FREQ = 900 ]; then
    echo "^fg(\#B3354C)"
fi
if [ $CPU_FREQ = 765 ]; then
    echo "^fg(\#A64286)"
fi
if [ $CPU_FREQ = 630 ]; then
    echo "^fg(\#337373)"
fi
