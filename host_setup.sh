#!/bin/bash

# The following commands create (on the host) virtual interfaces (veth-host1, veth-server1, ...) and connect virtual ethernet cables between them (veth-host1 - veth-switch1_1,  veth-server1 - veth-switch1_2)
ip link add veth-host1 type veth peer name veth-switch1_1
ip link add veth-server1 type veth peer name veth-switch1_2
ip link add veth-server2 type veth peer name veth-switch1_4
ip link add veth-switch1_3 type veth peer name eth1
ip link add veth-switch1_5 type veth peer name veth-gateway1
ip link add veth-networklab type veth peer name eth2
ip link add veth-gateway2 type veth peer name veth-switch2_1
ip link add veth-server3 type veth peer name veth-switch2_2
ip link add veth-server4 type veth peer name veth-switch2_3
ip link add veth-dns1 type veth peer name veth-switch1_6
ip link add veth-dns2 type veth peer name veth-switch2_5
ip link add veth-db type veth peer name veth-switch2_4

#The following commands move the virtual interfaces inside the container's network namespace
pid_host1=$(docker inspect -f '{{.State.Pid}}' host1)
ip link set veth-host1 netns /proc/${pid_host1}/ns/net

pid_server1=$(docker inspect -f '{{.State.Pid}}' server1)
ip link set veth-server1 netns /proc/${pid_server1}/ns/net 

pid_server2=$(docker inspect -f '{{.State.Pid}}' server2)
ip link set veth-server2 netns /proc/${pid_server2}/ns/net 

pid_switch1=$(docker inspect -f '{{.State.Pid}}' switch1)
ip link set veth-switch1_1 netns /proc/${pid_switch1}/ns/net
ip link set veth-switch1_2 netns /proc/${pid_switch1}/ns/net
ip link set veth-switch1_3 netns /proc/${pid_switch1}/ns/net 
ip link set veth-switch1_4 netns /proc/${pid_switch1}/ns/net 
ip link set veth-switch1_5 netns /proc/${pid_switch1}/ns/net 
ip link set veth-switch1_6 netns /proc/${pid_switch1}/ns/net 

pid_router1=$(docker inspect -f '{{.State.Pid}}' router1)
ip link set eth1 netns /proc/${pid_router1}/ns/net 
ip link set eth2 netns /proc/${pid_router1}/ns/net 

pid_gateway=$(docker inspect -f '{{.State.Pid}}' gateway)
ip link set veth-gateway1 netns /proc/${pid_gateway}/ns/net 
ip link set veth-gateway2 netns /proc/${pid_gateway}/ns/net 

pid_switch2=$(docker inspect -f '{{.State.Pid}}' switch2)
ip link set veth-switch2_1 netns /proc/${pid_switch2}/ns/net
ip link set veth-switch2_2 netns /proc/${pid_switch2}/ns/net
ip link set veth-switch2_3 netns /proc/${pid_switch2}/ns/net 
ip link set veth-switch2_5 netns /proc/${pid_switch2}/ns/net 
ip link set veth-switch2_4 netns /proc/${pid_switch2}/ns/net 


pid_server3=$(docker inspect -f '{{.State.Pid}}' server3)
ip link set veth-server3 netns /proc/${pid_server3}/ns/net 

pid_server4=$(docker inspect -f '{{.State.Pid}}' server4)
ip link set veth-server4 netns /proc/${pid_server4}/ns/net 

pid_dns=$(docker inspect -f '{{.State.Pid}}' dns)
ip link set veth-dns1 netns /proc/${pid_dns}/ns/net 
ip link set veth-dns2 netns /proc/${pid_dns}/ns/net 

pid_db=$(docker inspect -f '{{.State.Pid}}' db)
ip link set veth-db netns /proc/${pid_db}/ns/net 

ip link set veth-networklab up
ip addr add 192.168.100.2/24 dev veth-networklab
ip route add 192.168.10.0/24 via 192.168.100.1 dev veth-networklab 
ip route add 192.168.20.0/24 via 192.168.100.1 dev veth-networklab
ip route add 10.10.0.0/24 via 192.168.100.1 dev veth-networklab

# USEFUL COMMANDS TO DEBUG
# ip link show # shows information about interfaces 
# ls -l /proc/$PID/ns # to check the namespaces used by the container