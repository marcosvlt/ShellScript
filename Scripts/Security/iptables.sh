#!/bin/bash
#
#

# Flush all current rules from iptables

iptables -F

# Set default policies for INPUT, FORWARD and OUTPUT chains

iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT DROP # Ip drop will need change ssh rule

###############
#             #
# ALLOW RULES #
#             #
###############

########################################
# Allow SSH connections on tcp port 22 #
########################################
iptables -A INPUT -p tcp --dport 22 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
#Because iptables -P OUTPUT DROP
iptables -A OUTPUT -p tcp --sport 22 -m conntrack --ctstate ESTABLISHED -j ACCEPT

# Allow ssh OUTPUT
iptables -A OUTPUT -p tcp --dport 22 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
iptables -A INPUT -p tcp --sport 22 -m conntrack --ctstate ESTABLISHED -j ACCEPT

# SSH only for specific ip
#iptables -A INPUT -p tcp -s [YOUR_IP_ADDRESS] -m tcp --dport 22 -j ACCEPT
#
#SSH only for specific  network
#iptables -A INPUT -i eth0 -p tcp -s [IP_NETWORK/MASK] --dport 22 -m state --state NEW,ESTABLISHED -j ACCEPT
#iptables -A OUTPUT -o eth0 -p tcp --sport 22 -m state --state ESTABLISHED -j ACCEPT
# SSH outgoing  only to a specific network
#iptables -A OUTPUT -o eth0 -p tcp -d 192.168.101.0/24 --dport 22 -m state --state NEW,ESTABLISHED -j ACCEPT
#iptables -A INPUT -i eth0 -p tcp --sport 22 -m state --state ESTABLISHED -j ACCEPT

#######################################
# Allow Ping from Inside to Outside   #
#######################################
iptables -A OUTPUT -p icmp --icmp-type echo-request -j ACCEPT
iptables -A INPUT -p icmp --icmp-type echo-reply -j ACCEPT

#######################################
# Allow DNS lookup                    #
#######################################
iptables -A OUTPUT -p udp --dport 53 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A INPUT -p udp --sport 53 -m state --state ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p tcp --dport 53 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A INPUT -p tcp --sport 53 -m state --state ESTABLISHED -j ACCEPT


#######################################
# Allow Access for localhost          #
#######################################

iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

#######################################
# Allow HTTP                          #
#######################################
iptables -A INPUT -i eth0 -p tcp --dport 80 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -o eth0 -p tcp --sport 80 -m state --state ESTABLISHED -j ACCEPT
# outgoing HTTP
iptables -A OUTPUT -o eth0 -p tcp --dport 80 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A INPUT -i eth0 -p tcp --sport 80 -m state --state ESTABLISHED -j ACCEPT

#######################################
# Allow HTTPS                         #
#######################################
iptables -A INPUT -i eth0 -p tcp --dport 443 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -o eth0 -p tcp --sport 443 -m state --state ESTABLISHED -j ACCEPT

# outgoing HTTPS
iptables -A OUTPUT -o eth0 -p tcp --dport 443 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A INPUT -i eth0 -p tcp --sport 443 -m state --state ESTABLISHED -j ACCEPT


######################################################################
# Accept packets belonging to established and related connections    #
######################################################################
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT


######################################################################
# Allow Established Outgoing Connections                 								    #
######################################################################
iptables -A OUTPUT -m conntrack --ctstate ESTABLISHED -j ACCEPT




#DENY RULES
#DENY PING WITH A ERROR MESAGE
iptables -A INPUT -p icmp --icmp-type echo-request -j REJECT


#Drop Invalid Packets
iptables -A INPUT -m conntrack --ctstate INVALID -j DROP


# Internal network  to External.
# eth0 external 
# eth1 Internal
#
#iptables -A FORWARD -i eth1 -o eth0 -j ACCEPT


# Block an IP Address
# Use REJECT OR DROP
#
# iptables -A INPUT -s [IP_TO_BLOCK] -j DROP

# Block Connections to a Network Interface
#
#iptables -A INPUT -i [INTERFACE] -s [IP_TO_BLOCK] -j DROP


 
 
service iptables save
