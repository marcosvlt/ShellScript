#!/bin/bash
# Script to check if is workday or not
# Author https://github.com/marcosvlt
# 11/2020 - V.0.1
# ###################################

DAYOFWEEK=$(date +"%u")

if [ "$DAYOFWEEK" -ge 1 ] && [ "$DAYOFWEEK" -le 5 ];then

        echo "Dia de semana"

else

        echo "Final de semana"

fi
