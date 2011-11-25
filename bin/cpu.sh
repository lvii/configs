#!/bin/sh

let CPU_FREQ=`cat /proc/eee/fsb | cut -d " " -f1`*9
echo $CPU_FREQ
