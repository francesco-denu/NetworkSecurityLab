#!/bin/bash

# GATEWAY SETUP

ip link set veth-gateway1 up
ip addr add 10.10.0.2/24 dev veth-gateway1

ip link set veth-gateway2 up
ip addr add 192.168.50.2/24 dev veth-gateway2

#ip link set veth-gateway3 up
#ip addr add 10.10.0.5/24 dev veth-gateway3

echo "nameserver 10.10.0.3" > /etc/resolv.conf

ip route add default via 10.10.0.1
#ip route add 10.10.0.4/32 dev veth-gateway2 # route to the load balanced server
#ip route add 10.10.0.6/32 dev veth-gateway3 # route to the load balanced server 

# echo 1 > /proc/sys/net/ipv4/ip_forward # ip forwarding

ln -s /etc/nginx/sites-available/loadbalancer.conf /etc/nginx/sites-enabled/loadbalancer.conf
rm /etc/nginx/sites-enabled/default
nginx -s reload
# sites-available stores all your Nginx site configuration files
# sites-enabled/ contains symlinks to the configs in sites-available/ that Nginx actually loads and serves
# actually deleting default because its the classic web server configuration

