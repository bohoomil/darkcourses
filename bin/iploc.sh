#!/bin/sh

myip=`dig myip.opendns.com @resolver1.opendns.com +short`
loc=`geoiplookup $myip | cut -c 24-25`

echo "IP:$myip"; 

echo -en "country: \e[01;35m $loc\n";

exit 0
