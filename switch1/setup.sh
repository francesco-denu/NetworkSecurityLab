#!/bin/bash
# SWITCH 1

# The following commands set the interfaces UP
ip link set veth-switch1_1 up
ip link set veth-switch1_2 up
ip link set veth-switch1_3 up
ip link set veth-switch1_4 up
ip link set veth-switch1_5 up
ip link set veth-switch1_6 up

# Creates the OVS bridge
mkdir -p /var/run/openvswitch # directory used for the databases, containing configuration and so on ... 
chmod 755 /var/run/openvswitch

# Create the database (conf.db, storing configuration info) using the file schema vswitch.ovsschema
ovsdb-tool create /etc/openvswitch/conf.db /usr/share/openvswitch/vswitch.ovsschema
# Start the Database Server (ovsdb-server) which handles communication between the user and the actual OVS database (conf.db): provides remote management via ovs-vsctl
ovsdb-server --remote=punix:/var/run/openvswitch/db.sock --remote=db:Open_vSwitch,Open_vSwitch,manager_options --pidfile --detach
# Start the daemon which is actually responsible for the actual switching operations
ovs-vswitchd --pidfile --detach # stires tge oud ub /var/run

# Creating a new switch 
ovs-vsctl add-br br0

# Setting the ports (or interfaces) to access or trunk
ovs-vsctl add-port br0 veth-switch1_1 tag=10
ovs-vsctl add-port br0 veth-switch1_2 tag=20
ovs-vsctl add-port br0 veth-switch1_4 tag=20
ovs-vsctl add-port br0 veth-switch1_5 tag=30
ovs-vsctl add-port br0 veth-switch1_6 tag=30
ovs-vsctl add-port br0 veth-switch1_3 trunks=10,20,30 # connection to the router gateway

# USEFUL COMMANDS TO DEBUG
# ovs-vsctl list-br # check list of bridges
# ovs-vsctl show # check interface status
# ovs-appctl fdb/show br0 # check forwarding database
