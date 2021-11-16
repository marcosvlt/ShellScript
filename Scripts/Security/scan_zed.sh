#!/bin/bash
###########################
#
# Simple shell script to scan a list os hosts using owasp zed docker image
# list.txt without protocol only hostname
# Example: ./scan_zed.sh list.txt
#
###########################

LIST=$(cat $1)

for url in $LIST
do

	report=$(echo $url | awk -F "/" '{print $1}' )
	docker -D run --rm  -v $(pwd)/report:/zap/wrk/:rw -t owasp/zap2docker-stable zap-baseline.py -t https://$url -g gen.conf -r "$report".hml -d -m 1



done
