#!/bin/bash
iptables -F
iptables -X

iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP

iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A OUTPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A INPUT -p tcp -s 192.168.56.13 --dport 8080 -j ACCEPT

iptables -A OUTPUT -p tcp -d 192.168.56.10 --dport 5432 -j ACCEPT

iptables -A INPUT -j DROP
iptables -A OUTPUT -j DROP
