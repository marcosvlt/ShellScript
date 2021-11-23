#!/bin/bash
# Script to check swap out
# Author https://github.com/marcosvlt
# 11/2020 - V.0.1
# ###################################


SWAPOUT_ACTIVITY=$(vmstat 1 6 | tail -n 5 | awk '{ sum += $8 / 5 } END { print sum }' | awk -F "." '{print $1}')
SWAP_CRITICAL=1000

if [ "$SWAPOUT_ACTIVITY" -lt "$SWAP_CRITICAL"  ]; then
  
   echo "OK - Swap abaixo de 1/Mbs - $SWAPOUT_ACTIVITY"

elif [ "$SWAPOUT_ACTIVITY" -ge "$SWAP_CRITICAL" ]; then

    echo "CRITICAL - Swap acima de 1Mbs - - $SWAPOUT_ACTIVITY"

fi

exit
