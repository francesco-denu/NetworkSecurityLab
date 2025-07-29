#!/bin/bash

# DATABASE

ip link set veth-db up
ip addr add 192.168.50.5/24 dev veth-db

