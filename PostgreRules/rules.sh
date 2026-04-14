#!/bin/bash
iptables -F
iptables -X

iptables -P INPUT DROP
iptables -P OUTPUT FROP

iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A OUTPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A INPUT -p tcp -s 192.168.56.11 --dport 5432 -j ACCEPT

iptables -A INPUT -j DROP
iptables -A OUTPUT -j DROP

