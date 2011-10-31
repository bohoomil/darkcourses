#!/bin/sh
#===============================================================================
#
#          FILE:  loc.sh
# 
#         USAGE:  ./loc.sh 
# 
#   DESCRIPTION: returns external IP's country code 
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: YOUR NAME (), 
#       COMPANY: 
#       CREATED: 10/29/2010 05:48:19 AM CEST
#      REVISION:  ---
#===============================================================================

myip=`dig myip.opendns.com @resolver1.opendns.com +short`
loc=`geoiplookup $myip | cut -c 24-25`

echo "$loc"

exit 0
