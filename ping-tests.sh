#!/bin/bash

SSH_USER="admin"

test_server() {
    local server="$1"
    shift

    echo "========== $server =========="

    ssh -T "${SSH_USER}@${server}" /bin/sh -s <<EOF
while read dev gw; do
    if ping -6 -I "\$dev" -c 2 -W 2 "\$gw" >/dev/null 2>&1; then
        echo "[PASS] \$dev -> \$gw"
    else
        echo "[FAIL] \$dev -> \$gw"
    fi
done <<RAILS
$*
RAILS
EOF
}

test_server gpu-server1 \
"eth1 fd00:2:13:1:2:1:0:1
eth2 fd00:2:13:1:2:3:0:1
eth3 fd00:2:13:1:2:5:0:1
eth4 fd00:2:13:1:2:7:0:1
eth10 fd00:2:13:2:2:1:0:1
eth20 fd00:2:13:2:2:3:0:1
eth30 fd00:2:13:2:2:5:0:1
eth40 fd00:2:13:2:2:7:0:1"

test_server gpu-server2 \
"eth1 fd00:2:13:1:2:2:0:1
eth2 fd00:2:13:1:2:4:0:1
eth3 fd00:2:13:1:2:6:0:1
eth4 fd00:2:13:1:2:8:0:1
eth10 fd00:2:13:2:2:2:0:1
eth20 fd00:2:13:2:2:4:0:1
eth30 fd00:2:13:2:2:6:0:1
eth40 fd00:2:13:2:2:8:0:1"
