#!/bin/bash
###########################
#
# Check if url exists on a list and split in two lists. 
# Example: ./checkURL.sh list.txt
#
###########################

LIST=$(cat "$1")

for url in $LIST
do
        if wget -q -t 1 -T 10 --method=HEAD http://"$url";
        then

                printf "%s exist \n" "$url"
                echo "$url" >> validUrls.txt
        else
                printf "%s don't exist \n" "$url"
                echo "$url" >> invalidUrls.txt
        fi

done
