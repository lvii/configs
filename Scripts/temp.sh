#!/bin/sh

acpi -t | cut -d " " -f4 | cut -d "." -f1
