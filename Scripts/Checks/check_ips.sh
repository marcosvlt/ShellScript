#!/bin/bash
###########################
#
# Ping and generate a list with url and ip
# Example: ./check_ips.sh list.txt
# Author: github.com/marcosvlt
#
###########################


LIST=$(cat $1)


for url in $LIST
do
	
	ip=$(ping -c 1 -i 1 -t 1 $url |  sed -nE 's/^PING[^(]+\(([^)]+)\).*/\1/p')
	echo $url $ip
	echo $url $ip >> urle
