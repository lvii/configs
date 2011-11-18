#!/bin/sh
ls -g --no-group -h --time-style=+%y%m%d $1 | cut -d " " -f4
