#!/bin/sh
#
## CPU control menu for ASUS Eee PC 701
## author  : OK <ok100.ok100.ok100@gmail.com>
## website : https://github.com/ok100 
#

TMP_FILE=/tmp/cpu_control.txt
FSB=`cat /proc/eee/fsb`

if [ "$FSB" = "70 24 0" ]; then
    MENU="item=High\n
		  cmd=sudo /home/ok/bin/eeecpufreq -f 900\n
          icon=null\n
          \n
          item=Medium\n
		  cmd=sudo /home/ok/bin/eeecpufreq -f 729\n
          icon=null"
fi

if [ "$FSB" = "81 24 0" ]; then
    MENU="item=High\n
		  cmd=sudo /home/ok/bin/eeecpufreq -f 900\n
          icon=null\n
          \n
          item=Low\n
		  cmd=sudo /home/ok/bin/eeecpufreq -f 630\n
          icon=null"
fi

if [ "$FSB" = "100 24 1" ]; then
    MENU="item=Medium\n
		  cmd=sudo /home/ok/bin/eeecpufreq -f 729\n
          icon=null\n
          \n
          item=Low\n
		  cmd=sudo /home/ok/bin/eeecpufreq -f 630\n
          icon=null"
fi

echo -e $MENU > $TMP_FILE

mygtkmenu $TMP_FILE > /dev/null
