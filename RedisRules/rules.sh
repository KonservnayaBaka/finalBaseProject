#!/bin/bash
iptables -F
iptables -X

iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP

iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A OUTPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A INPUT -p tcp -s 192.168.56.13 --dport 6379 -j ACCEPT

iptables -A INPUT -j DROP
iptables -A OUTPUT -j DROP

#В задании хоть не указаны настройки для редис, но как понял он принимает подключения только от прокси

