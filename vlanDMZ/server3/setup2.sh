#!/bin/bash

# SERVER 4 SETUP (clone of server 3)

ip link set veth-server4 up
ip addr add 192.168.50.4/24 dev veth-server4
ip route add default dev veth-server4

echo "nameserver 192.168.50.6" > /etc/resolv.conf

python manage.py runserver 0.0.0.0:8000