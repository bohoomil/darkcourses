#!/bin/sh

myip=`dig myip.opendns.com @resolver1.opendns.com +short`
loc=`geoiplookup $myip | cut -c 24-25`

echo "$loc"

exit 0
