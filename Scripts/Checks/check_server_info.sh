#!/bin/bash
##########################################################################
# Shellscript:  Simple Shell script for gathering server information
# Author     :	https://github.com/marcosvlt
# Requires   :	Nothing
# Date	     :  08/01/2017
##########################################################################
# Description
# Notes
# 	* Tested in Centos 7.
#
##########################################################################

# Bash css!
red="\033[0;31m"
blue="\033[0;34m"
nc="\033[0m"


#Verify root
USERID=$(id -g)
if [ "$USERID" == 0 ]; then
	echo ""
else
	echo -e "\n${red}Please run the script using root user${nc}\n"
exit
fi



#Search for external Ip informations.
GetExternalIp(){

curl -s ipinfo.io > /tmp/ExternalIp 


}

# Verify the existence of determined command
Vcheck() {

if hash "$1" 2>/dev/null; then

        if [ "$1" = "php" ]; then
        echo "PHP $(php -v | awk 'NR==1{print $2}')"

        fi

        if [ "$1" = "mysql" ]; then
        echo "Mysql $(mysql --version | awk '{print $5}')"

        fi

        if [ "$1" = "openssl" ];then

        openssl version |awk '{print $1, $2}'
        fi

	if [ "$1" = "smbclient" ]; then

	echo "Samba Client: $(smbclient -V)"
	fi

	if [ "$1" = "smbd" ]; then

	echo "Samba Daemon: $(smbd -V)"

	fi

	if [ "$1" = "httpd" ];then
	
	echo "Apache: $(ttpd -v)"

	fi

	if [ "$1" = "git" ];then

	echo "Git: $(git --version |  awk '{print $3}')"
	
	fi

else
    echo "$1 not found"

fi
}


#Display Date
echo -e  "\n Date : $(date)\n"


# General Info
echo -e "${red}GENERAL INFORMATION ${nc}   \n"
echo "Hostname: $(hostname)"
echo "Uptime: $(uptime | awk '{print $3, $4}')"
echo "CPU idle: $(vmstat 1 2 | sed -n '/[0-9]/p' | sed -n '2p' | gawk '{print $15}')"
echo "Architecture: $(uname -m)"
echo "Linux Kernel: $(uname -r)"
echo "Linux Distro: $(cat /etc/*-release | head -1)"

# Cpu Info
echo -e "\n${red}CPU  INFORMATION\n ${nc}"
echo "CPU model: $(grep  "model name" /proc/cpuinfo | awk -F ":" '{print $02}')"
echo "CPU Speed: $(grep "cpu MHz" /proc/cpuinfo | awk -F ":" '{print $02}')"
echo "Cache Size: $(grep "cache size" /proc/cpuinfo | awk -F ":" '{print $02}')"

# Memory Info
echo -e "\n${red}MEMORY INFORMATION ${nc}\n"
free -m


echo -e "\n${red}FILE SYSTEM INFORMATION ${nc}\n"
df -h

# NET INFO 
echo -e  "\n${red}NETWORK  INFORMATION ${nc}\n"
echo -e "${blue}Hostname:${nc} "
cat /etc/resolv.conf
echo -e "${blue}Ip address: ${nc}"
ip addr | grep enp0* | grep inet | awk '{print "\033[31m"$7" \033[0m"$2;  }'
echo -e "${blue}Route:${nc}"
ip route show
echo -e "${blue}External IP Adress: ${nc}"
echo "Loading..."

#GetExternalIp 
GetExternalIp
echo "IP:$(cat /tmp/ExternalIp  | grep ip | awk  '{print $2}' | sed 's/[",]//g')"
echo "Hostname:$(cat /tmp/ExternalIp  | grep hostname | awk  '{print $2}' | sed 's/[",]//g')"
echo "Region:$(cat /tmp/ExternalIp  | grep region | awk -F ":"  '{print $2}' | sed 's/[",]//g')"
echo "Country:$(cat /tmp/ExternalIp  | grep country | awk -F ":"  '{print $2}' | sed 's/[",]//g')"

#Version check

echo -e "\n${red}VERSION INFORMATION ${nc}\n"
Vcheck php
Vcheck mysql
Vcheck openssl
Vcheck smbclient 
Vcheck smbd
Vcheck httpd 
Vcheck git
