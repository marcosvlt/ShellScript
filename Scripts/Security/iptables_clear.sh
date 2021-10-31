#!/bin/bash
###########################
# clear iptables
###########################

# Change all filter chains to ACCEPT POLICY
iptables -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT
iptables -P FORWARD ACCEPT

# Delete all rules in all CHAINS
iptables -t filter -F
iptables -t nat -F
iptables -t mangle -F
iptables -t raw -F

# Delete user-defined CHAIN
iptables -X
