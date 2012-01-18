#!/bin/sh

myip=$(dig myip.opendns.com @resolver1.opendns.com +short)
loc=$(geoiplookup $myip | awk -F' ' '{print $4}' | sed '$s/,$//')

echo "IP: $myip"; 

echo -en "country:\e[01;35m $loc\e[0m\n";

exit 0
