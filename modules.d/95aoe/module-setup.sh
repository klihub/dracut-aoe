#!/usr/bin/bash

# called by dracut
check() {
    require_binaries ifconfig || return 1
    return 0
}

# called by dracut
depends() {
    echo rootfs-block
}

# called by dracut
installkernel() {
    hostonly='' instmods aoe $(ls /sys/class/net | grep -v lo)
}

# called by dracut
install() {
    inst_multiple ifconfig
    inst_hook pre-trigger 30 "$moddir/aoe-prepare.sh"
    inst_script "$moddir/aoe-trigger-discovery.sh" /bin/aoe-trigger-discovery
}
