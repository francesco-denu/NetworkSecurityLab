#!/bin/vbash

# ROUTER 1 CONFIG
# https://docs.vyos.io/en/latest/configuration/firewall/ipv4.html#firewall-ipv4-rules


# checking if the group is vyattacfg 
#if [ "$(id -g -n)" != 'vyattacfg' ] ; then
#    exec sg vyattacfg -c "/bin/vbash $(readlink -f $0) $@"
#fi

#su - vyos

source /opt/vyatta/etc/functions/script-template

configure

# Configuring the VLAN subinterfaces, and creating vif (virtual interfaces) for each VLAN
set interfaces ethernet eth1 vif 10 address 192.168.10.1/24
set interfaces ethernet eth1 vif 20 address 192.168.20.1/24
set interfaces ethernet eth1 vif 30 address 10.10.0.1/24
# Configuring router in the host machine direction
set interfaces ethernet eth2 address 192.168.100.1/24

# FIREWALL 1: THE GOAL IS TO ALLOW COMMUNICATION FROM EXETRNAL ONLY TO THE DMZ, NOT THE REST OF THE LAN

# Creating zones
set firewall zone LAN member interface eth1.10 # 192.168.10.0/24
set firewall zone LAN member interface eth1.20 # 192.168.20.0/24
set firewall zone LAN member interface eth1.30 # 10.10.0.0/24
set firewall zone EXTERNAL member interface eth2 # 192.168.100.0/24

# Creating ruleset: EXTERNAL -> LAN 
set firewall ipv4 name EXTERNAL-to-LAN default-action drop # default drop
# Allow from EXTERNAL to 10.10.0.0/24 (VLAN 30)
set firewall ipv4 name EXTERNAL-to-LAN rule 10 action accept
set firewall ipv4 name EXTERNAL-to-LAN rule 10 destination address 10.10.0.0/24
# Associating ruleset to zone
set firewall zone LAN from EXTERNAL firewall name EXTERNAL-to-LAN 

# Creating ruleset: LAN -> EXTERNAL 
# NOTE THAT BY DEFAULT A ZONE BLOCKS EVERYTHING, SO IF YOU WANT TO ALLOW TRAFFIC YOU NEED TO EXPLICITLY SAY IT WITH A RULE
set firewall ipv4 name LAN-to-EXTERNAL default-action accept
# Associating ruleset to zone
set firewall zone EXTERNAL from LAN firewall name LAN-to-EXTERNAL 

commit
save
exit


# USEFUL COMMANDS TO DEBUG
# show interfaces # checks the vlan interfaces 
# show configuration
# show firewall
# delete firewall
