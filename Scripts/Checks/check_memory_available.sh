#!/bin/bash
# ###################################
# Script to check memory avaliable
# Marcos  10/2017 - V.0.1
# ###################################

MEMORIA=$( free -m | grep -i mem | awk '{ print $2 }')
AVALIABLE=$(free -m | grep -i mem | awk '{ print $7 }')
PERCENT_FREE=$( free | grep Mem | awk '{print $7/$2 * 100}' |  awk -F "." '{print $1}' )

if [ "$PERCENT_FREE" -ge 10 ]; then

        echo "OK - ${AVALIABLE}M de Memoria available livre. $PERCENT_FREE% livre "

elif [ "$PERCENT_FREE" -ge 06 ] && [ "$PERCENT_FREE" -le 9 ]; then

    echo "WARNING - ${AVALIABLE}M de Memoria available livre. $PERCENT_FREE% livre "


elif [ "$PERCENT_FREE" -le 5 ]; then

    STATUS="2"

fi
exit $STATUS
