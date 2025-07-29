#!/bin/bash
# SERVER 1 SETUP

ip link set veth-server1 up
ip addr add 192.168.20.2/24 dev veth-server1
ip route add default via 192.168.20.1

echo "nameserver 10.10.0.3" > /etc/resolv.conf