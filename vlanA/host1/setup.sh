#!/bin/bash
# HOST 1 SETUP

ip link set veth-host1 up
ip addr add 192.168.10.2/24 dev veth-host1
ip route add default via 192.168.10.1

echo "nameserver 10.10.0.3" > /etc/resolv.conf