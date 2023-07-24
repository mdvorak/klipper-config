#!/bin/sh
set -e

# Requires
# sudo apt install iptables-persistent

PATH=/bin:/usr/bin:/usr/local/bin:/sbin:/usr/sbin:/usr/local/sbin
#------------------------------------------------------------------------------
#***** Remove all rules, set input and forward policy to DROP
iptables -P INPUT   DROP
iptables -P FORWARD DROP
iptables -P OUTPUT  ACCEPT
iptables -t nat -P PREROUTING  ACCEPT
iptables -t nat -P POSTROUTING ACCEPT
iptables -t nat -P OUTPUT      ACCEPT
iptables -F
iptables -X
iptables -t nat -F
iptables -t nat -X
iptables -t mangle -F
iptables -t mangle -X

#------------------------------------------------------------------------------
#***** Declare additional chain names
iptables -N icmp_packets

#***** allow all to 127.0.0.1
iptables -I INPUT 1 -i lo -j ACCEPT

#***** drop invalid packets
iptables -A FORWARD -m state --state INVALID -j DROP

#***** allow all established and related traffic
iptables -A INPUT   -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A FORWARD -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

#***** allow ssh
iptables -A INPUT  -p tcp  --dport 22    -j ACCEPT

#***** allow https (mainsail)
iptables -A INPUT  -p tcp  --dport 443  -s 192.168.0.0/24 -j ACCEPT
iptables -A INPUT  -p tcp  --dport 7130 -s 192.168.0.0/24 -j ACCEPT
iptables -A INPUT  -p tcp  --dport 7125 -s 192.168.0.9    -j ACCEPT

#***** allow mDNS
iptables -A INPUT   -m pkttype --pkt-type multicast -j ACCEPT
iptables -A FORWARD -m pkttype --pkt-type multicast -j ACCEPT
iptables -A OUTPUT  -m pkttype --pkt-type multicast -j ACCEPT

#***** catch icmp packets and send them to chain icmp_packets
iptables -A INPUT  -p icmp -j icmp_packets

#***** Drop packets that made it all the way down here.
#***** There shouldn't be any, but you never know...
iptables -A INPUT   -j DROP
iptables -A FORWARD -j DROP

#------------------------------------------------------------------------------
#***** chain icmp, allow some icmp packets
#***** 0=Echo Reply  3=Destination Unreachable  5=Redirect  8=Echo  11=Time Exceeded
iptables -A icmp_packets -p icmp -s 0/0 --icmp-type 0  -j ACCEPT
iptables -A icmp_packets -p icmp -s 0/0 --icmp-type 3  -j ACCEPT
iptables -A icmp_packets -p icmp -s 0/0 --icmp-type 8  -j ACCEPT
iptables -A icmp_packets -p icmp -s 0/0 --icmp-type 11 -j ACCEPT
iptables -A icmp_packets -p icmp -s 0/0                -j DROP
#------------------------------------------------------------------------------
echo "*** rc.firewall was executed on $(uname -n) ***"

echo "Don't forget to persist rules with"
echo "sudo iptables-save > /etc/iptables/rules.v4"
