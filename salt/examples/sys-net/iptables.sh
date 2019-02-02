#!/bin/sh
/sbin/iptables -P OUTPUT DROP
/sbin/iptables -F OUTPUT 
/sbin/iptables -I OUTPUT -o lo -j ACCEPT
