#!/bin/bash
# ###################################
# Script to check memory
# Marcos  10/2017 - V.0.1
# ###################################


MEMORIA=$( free -m | grep -i mem | awk '{ print $4 }')
FREE=$(free -m | grep -i mem | awk '{ print $4 }')
PERCENT_FREE=$( free | grep Mem | awk '{print $4/$2 * 100}' |  awk -F "." '{print $1}' )

if [ "$PERCENT_FREE" -ge 20 ]; then
       
      echo "OK - ${FREE}M Free Memory"

elif [ "$PERCENT_FREE" -ge 11 ] && [ "$PERCENT_FREE" -le 19 ]; then
      
      echo "WARNING - ${FREE}M Free Memory. $PERCENT_FREE% Free "


elif [ "$PERCENT_FREE" -le 10 ]; then
       echo "CRITICAL - ${FREE}M Free Memory. $PERCENT_FREE% Free "
    

fi
exit
