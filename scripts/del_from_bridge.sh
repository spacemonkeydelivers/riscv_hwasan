#!/bin/bash

BRIDGE="br0"

ip addr flush dev $1
ip link set $1 down
#ovs-vsctl del-port ${BRIDGE} $1

/usr/sbin/brctl delif ${BRIDGE} $1
# 
# only a single bridge so loops are not possible, turn off spanning tree protocol
#
#/usr/sbin/brctl stp ${BRIDGE} off 
