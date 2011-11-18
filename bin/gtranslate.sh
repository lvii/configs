#!/bin/sh

if [ $# == 3 ]; then
    echo "From: $1 To: $2"
    lynx -dump "http://ajax.googleapis.com/ajax/services/language/translate?v=1.0&q=$3&langpair=$1|$2"|awk -F'"' '{print $6}'
else
    lynx -dump "http://ajax.googleapis.com/ajax/services/language/translate?v=1.0&q=$1&langpair=|cs"|awk -F'"' '{print "From: "$10" To: cs \n"$6}';echo
fi
