#!/bin/bash
##########################################################################
# Shellscript:  Backup current user home and move to another machine.
# Author     :	https://github.com/marcosvlt
# Requires   :	Nothing
# Date	     :  08/03/2017
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

# Define current user

user=$(whoami)

################
# functions    #
################

HomeTar(){

tar cvzf /home/"${user}"/backup"${user}".tar.gz /home/"${user}"/*

}

RootTar(){

tar cvzf /root/backup-root.tar.gz /root/*

}

################
# Main Program #
################

#Verify root
if [ "$user" == "root" ]; then
	RootTar
else

	HomeTar

exit
fi
home_backup.sh
