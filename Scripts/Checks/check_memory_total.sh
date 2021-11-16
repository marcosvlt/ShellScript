#!/bin/bash 
# Script to check memory
# Marcos  12/2017 - V.1.0
# Check free and available
# ###################################


MEMORIA_TOTAL=$(free -m | grep -i mem | awk '{ print $2 }')
AVALIABLE=$(free -m | grep -i mem | awk '{ print $7 }')
MEMORIA_FREE=$(free -m | grep -i mem | awk '{ print $4 }')
let PERCENT_FREE="($AVALIABLE + $MEMORIA_FREE) * 100  / $MEMORIA_TOTAL  "
MEMORIA_FREE_TOTAL=$(($AVALIABLE + $MEMORIA_FREE))


if [ $PERCENT_FREE -ge 10 ]; then
  
        echo "OK - ${MEMORIA_FREE_TOTAL}M de Memoria TOTAL livre. $PERCENT_FREE% livre "

elif [ $PERCENT_FREE -ge 06 ] && [ $PERCENT_FREE -le 9 ]; then
  
    echo "WARNING - ${MEMORIA_FREE_TOTAL}M de Memoria TOTAL livre. $PERCENT_FREE% livre "


elif [ $PERCENT_FREE -le 5 ]; then

    echo "CRITICAL - ${MEMORIA_FREE_TOTAL}M de Memoria TOTAL livre. $PERCENT_FREE% livre "
   

fi
