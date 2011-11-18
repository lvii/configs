#!/bin/sh
#
## cpu.sh
## author  : OK <ok100.ok100.ok100@gmail.com>
## website : https://github.com/ok100
#

CPU_FREQ=`cat /proc/eee/fsb | cut -d " " -f1`
if [ $CPU_FREQ = 100 ]; then
    echo "^fg(\#B3354C)"
fi
if [ $CPU_FREQ = 85 ]; then
    echo "^fg(\#A64286)"
fi
if [ $CPU_FREQ = 70 ]; then
    echo "^fg(\#337373)"
fi
