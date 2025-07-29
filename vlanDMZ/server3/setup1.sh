#!/bin/bash

# SERVER 3 SETUP

ip link set veth-server3 up
ip addr add 192.168.50.3/24 dev veth-server3
ip route add default dev veth-server3

echo "nameserver 192.168.50.6" > /etc/resolv.conf

python manage.py migrate && python manage.py runserver 0.0.0.0:8000 &