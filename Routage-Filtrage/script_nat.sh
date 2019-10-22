#§bin/sh

echo 1 > /proc/sys/net/ipv4/ip_forward


iptables -t nat -A POSTROUTING -s 200.3.3.0/24 -j MASQUERADE
