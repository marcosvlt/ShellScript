#!/bin/bash
# Script to check load
# Author https://github.com/marcosvlt
# 11/2020 - V.0.1
# ###################################

PROCS=$(grep -c ^processor /proc/cpuinfo)
LOAD=$(< /proc/loadavg awk '{print $1}' awk -F"." '{print $1}')
PERCENT=$(awk "BEGIN  {print $PROCS*0.8}" | awk -F "." '{print $1}' )


if [ "$LOAD" -lt "$PERCENT"  ]; then
         
        echo "OK - Status Load Average - $LOAD de $PROCS"

elif [ "$LOAD" -ge "$PERCENT" ] && [ "$LOAD" -lt "$PROCS" ]; then
       
       echo "WARNING - Status Load Average - $LOAD de $PROCS"

elif [ "$LOAD" -ge  "$PROCS" ]; then
        
        echo "CRITICAL - Status Load Average - $LOAD de $PROCS"

fi
