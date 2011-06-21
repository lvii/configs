#!/bin/sh
#
## eeecpufreq.sh
## author  : OK <ok100.ok100.ok100@gmail.com>
## website : https://github.com/ok100
#

let CPU_FREQ=`cat /proc/eee/fsb | cut -d " " -f1`*9
echo $CPU_FREQ
