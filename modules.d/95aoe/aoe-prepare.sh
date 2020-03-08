#!/usr/bin/bash

type getarg >/dev/null 2>&1 || . /lib/dracut-lib.sh

info "installing AoE module, preparing AoE discovery..."
modprobe aoe e1000
echo "/bin/aoe-trigger-discovery" > $hookdir/initqueue/finished/aoe-discover.sh
