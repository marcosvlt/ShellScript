#!/bin/sh
###########################
#
# Send e-mail with aide report 
# Used with cron 
#
###########################

DATE=$(date +%Y-%m-%d)
LOGFILE="/var/log/aide.${DATE}.txt"
REPORT="Aide-"$DATE.txt
EMAILMSG="AIDE Marcos "
EMAILTO=""
DB="/var/lib/aide/aide.db.gz"

aide --check > "${LOGFILE}"

mailx -s "$EMAILMSG" -A "$LOGFILE" -A $DB "$EMAILTO" < /dev/null

# Ideia to implemente some modification https://wiki.archlinux.org/index.php/AIDE
# Since the database is stored on the root filesystem, attackers can easily modify it to cover their tracks if they compromise your system. 
# You may want to copy the database to offline, read-only media and perform checks against this copy periodically. 
