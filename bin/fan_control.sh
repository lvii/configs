#!/bin/sh
#
## fan control menu for ASUS Eee PC 701
## author  : OK <ok100.ok100.ok100@gmail.com>
## website : https://github.com/ok100 
#

TMP_FILE=/tmp/fan_control.txt
MANUAL=`cat /proc/eee/fan_manual`

if [ $MANUAL = 0 ]; then
    MENU="item=Manual\n
          cmd=sudo sh -c 'echo 1 > /proc/eee/fan_manual'\n
          icon=null"
fi
if [ $MANUAL = 1 ]; then
    MENU="item=Automatic\n
          cmd=sudo sh -c 'echo 0 > /proc/eee/fan_manual'\n
          icon=null\n
          \n
          item=50%\n
          cmd=sudo sh -c 'echo 50 > /proc/eee/fan_speed'\n
          icon=null\n
          \n
          item=45%\n
          cmd=sudo sh -c 'echo 45 > /proc/eee/fan_speed'\n
          icon=null\n
          \n
          item=40%\n
          cmd=sudo sh -c 'echo 40 > /proc/eee/fan_speed'\n
          icon=null\n
          \n
          item=35%\n
          cmd=sudo sh -c 'echo 35 > /proc/eee/fan_speed'\n
          icon=null\n
          \n
          item=30%\n
          cmd=sudo sh -c 'echo 30 > /proc/eee/fan_speed'\n
          icon=null\n
          \n
          item=25%\n
          cmd=sudo sh -c 'echo 25 > /proc/eee/fan_speed'\n
          icon=null\n
          \n
          item=20%\n
          cmd=sudo sh -c 'echo 20 > /proc/eee/fan_speed'\n
          icon=null"
fi

echo -e $MENU > $TMP_FILE

mygtkmenu $TMP_FILE > /dev/null

