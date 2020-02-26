#!/bin/bash

set -x

BR_NAME=$1
MAIN_CONN=$2

MAC_MAIN_CONN=$(nmcli -g GENERAL.HWADDR dev show $MAIN_CONN | sed -e 's/\\//g')

nmcli c delete "$MAIN_CONN"
nmcli c delete "Wired connection 1"
nmcli c add type bridge ifname "$BR_NAME" autoconnect yes con-name "$BR_NAME" stp no bridge.mac-address $MAC_MAIN_CONN
nmcli c add type bridge-slave autoconnect yes con-name "$MAIN_CONN" ifname "$MAIN_CONN" master "$BR_NAME"
systemctl restart NetworkManager
echo "net.ipv4.ip_forward = 1" | tee /etc/sysctl.d/99-ipforward.conf
sysctl -p /etc/sysctl.d/99-ipforward.conf
