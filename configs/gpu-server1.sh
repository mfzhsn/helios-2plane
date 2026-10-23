#!/bin/sh
set -e

configure() {
    dev=$1
    addr=$2
    gw=$3
    table=$4
    priority=$5

    ip link set "$dev" up
    ip -6 addr replace "$addr/96" dev "$dev"
    ip -6 route replace default via "$gw" dev "$dev" table "$table"

    while ip -6 rule del priority "$priority" 2>/dev/null; do :; done
    ip -6 rule add priority "$priority" from "$addr/128" table "$table"
}

configure eth1  fd00:2:13:1:2:1:0:2 fd00:2:13:1:2:1:0:1 101 1001
configure eth2  fd00:2:13:1:2:3:0:2 fd00:2:13:1:2:3:0:1 102 1002
configure eth3  fd00:2:13:1:2:5:0:2 fd00:2:13:1:2:5:0:1 103 1003
configure eth4  fd00:2:13:1:2:7:0:2 fd00:2:13:1:2:7:0:1 104 1004
configure eth10 fd00:2:13:2:2:1:0:2 fd00:2:13:2:2:1:0:1 105 1005
configure eth20 fd00:2:13:2:2:3:0:2 fd00:2:13:2:2:3:0:1 106 1006
configure eth30 fd00:2:13:2:2:5:0:2 fd00:2:13:2:2:5:0:1 107 1007
configure eth40 fd00:2:13:2:2:7:0:2 fd00:2:13:2:2:7:0:1 108 1008