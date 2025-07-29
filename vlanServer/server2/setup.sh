#!/bin/bash
# SERVER 2 SETUP

ip link set veth-server2 up
ip addr add 192.168.20.3/24 dev veth-server2
ip route add default via 192.168.20.1

echo "nameserver 10.10.0.3" > /etc/resolv.conf