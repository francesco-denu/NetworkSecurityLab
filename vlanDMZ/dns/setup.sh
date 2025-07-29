#!/bin/bash
# DNS

ip link set veth-dns1 up
ip link set veth-dns2 up

ip addr add 10.10.0.3/24 dev veth-dns1
ip addr add 192.168.50.6/24 dev veth-dns2

ip route add default via 10.10.0.1