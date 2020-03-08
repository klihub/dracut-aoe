#!/usr/bin/bash

type getarg >/dev/null 2>&1 || . /lib/dracut-lib.sh

# bring up all interfaces other than loopback
for dev in /sys/class/net/*; do
    name=${dev##*/}
    info "checking interface $name ($dev)..."
    [ "$name" = "*" ] && return 1
    [ "$name" = "lo" ] && continue
    carrier=$(cat $dev/carrier)
    state=$(cat $dev/operstate)
    if [ "$carrier" = "1" -a "$state" != "up" ]; then
	ifconfig $name up
    fi
done

# trigger aoe-discovery
echo "" > /dev/etherd/discover || exit 1

status=1
for dev in /dev/etherd/e[0-9]*; do
    name=${dev##*/}
    [ "$name" = "e[0-9]*" ] && break
    info "discovered AoE device $name..."
    status=0    
done
exit $status
