#!/bin/sh
########################
# Autor: Marcos Silvello
# Data: 03/2020
# Modified from the original 
# rkhunter crontab
#######################

RKHUNTER=/usr/bin/rkhunter
NICE=0
# source config
. /etc/default/rkhunter

case "$CRON_DAILY_RUN" in
     [YyTt]*)
        OUTFILE=`mktemp`.$(hostname).txt || exit 1
        /usr/bin/nice -n $NICE $RKHUNTER --cronjob --report-warnings-only --appendlog > $OUTFILE
        if [ -s "$OUTFILE" -a -n "$REPORT_EMAIL" ]; then
                mailx -s "Cron Daily RkHunter $(hostname)" -A $OUTFILE $REPORT_EMAIL < /dev/null
        else
                mail -s "Cront Daily Rkhunter $(hostname) - EVERYTHING OK " $REPORT_EMAIL  </dev/null
        fi
        rm -f $OUTFILE
        ;;
      *)
       exit 0
