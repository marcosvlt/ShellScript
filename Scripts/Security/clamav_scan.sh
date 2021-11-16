#!/bin/bash
# Script to rum clamav and move infected files
# and send an email
# requires mail
# Author https://github.com/marcosvlt
# 11/2020 - V.0.1
# ###################################

LOGFILE="/var/log/clamav/clamav-script-$(date +'%Y-%m-%d_%H%M').$(hostname).log"
DIRTOSCAN="/";
INFECTEDDIR="/etc/clamav/infected"
EMAILMSG="ClamavScan $(hostname)";
EMAILTO="mail@mail.com";

echo "
$(date)
Starting scan of '$DIRTOSCAN'
"> "$LOGFILE"


#Create a quarentine folder
if [ -e $INFECTEDDIR ]; then
    echo "Infected folder already exist" >> "$LOGFILE"
else
    mkdir $INFECTEDDIR
    echo "Created infected folder" >> "$LOGFILE"
fi

clamscan -ri  --exclude-dir=$INFECTEDDIR --move=$INFECTEDDIR $DIRTOSCAN  >> "$LOGFILE"


#Remove infected files permissions
if [ "$(ls -A $INFECTEDDIR)" ]; then
    echo "-------------------------" >> "$LOGFILE"
    echo "Removing infected files permissions" >> "$LOGFILE"
    chmod -R 000 $INFECTEDDIR
else
    echo "Infected folder empty" >> "$LOGFILE"
fi

echo "Complete at $(date)" >> "$LOGFILE"

mail -A "$LOGFILE" -s "$EMAILMSG" "$EMAILTO" < /dev/null
