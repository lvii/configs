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
          cmd=sudo sh -c 'echo 75 24 0  > /proc/eee/fsb;
                          echo 80 24 0  > /proc/eee/fsb;
                          echo 85 24 0  > /proc/eee/fsb;
                          echo 90 24 1  > /proc/eee/fsb;
                          echo 95 24 1  > /proc/eee/fsb;
                          echo 100 24 1 > /proc/eee/fsb'\n
          icon=null\n
          \n
          item=Medium\n
          cmd=sudo sh -c 'echo 75 24 0  > /proc/eee/fsb;
                          echo 80 24 0  > /proc/eee/fsb;
                          echo 85 24 0  > /proc/eee/fsb'\n
          icon=null"
fi

if [ "$FSB" = "85 24 0" ]; then
    MENU="item=High\n
          cmd=sudo sh -c 'echo 90 24 1  > /proc/eee/fsb;
                          echo 95 24 1  > /proc/eee/fsb;
                          echo 100 24 1 > /proc/eee/fsb'\n
          icon=null\n
          \n
          item=Low\n
          cmd=sudo sh -c 'echo 80 24 0  > /proc/eee/fsb;
                          echo 75 24 0  > /proc/eee/fsb;
                          echo 70 24 0  > /proc/eee/fsb'\n
          icon=null"
fi

if [ "$FSB" = "100 24 1" ]; then
    MENU="item=Medium\n
          cmd=sudo sh -c 'echo 95 24 1  > /proc/eee/fsb;
                          echo 90 24 1  > /proc/eee/fsb;
                          echo 85 24 0  > /proc/eee/fsb'\n
          icon=null\n
          \n
          item=Low\n
          cmd=sudo sh -c 'echo 95 24 1  > /proc/eee/fsb;
                          echo 90 24 1  > /proc/eee/fsb;
                          echo 85 24 0  > /proc/eee/fsb;
                          echo 80 24 0  > /proc/eee/fsb;
                          echo 75 24 0  > /proc/eee/fsb;
                          echo 70 24 0  > /proc/eee/fsb'\n
          icon=null"
fi

echo -e $MENU > $TMP_FILE

mygtkmenu $TMP_FILE > /dev/null
