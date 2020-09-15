#!/bin/bash

delete-ports() {
    echo "Delete all ports"
    netID="$(openstack network show $1 -f json |jq -r ".id")"
    echo "Network id: $netID"
    pIDs="$(openstack port list --network $netID -f json | jq -r ".[] | .ID")"
    for i in $pIDs; do
      echo "Delete port id: $i"
        openstack port delete $i
    done
}

delete-subnets() {
    echo "Delete all subnets"
    sIDs="$(openstack network show $1 -f json | jq -r ".subnets")"
    for i in $sIDs; do
        echo "Delete subnet $i"
        openstack subnet delete $i
    done
}

# delete load balancer
delete-net() {
    echo "Delete net $1"
    openstack network delete $1
}

delete-ports $1
delete-subnets $1
delete-net $1
