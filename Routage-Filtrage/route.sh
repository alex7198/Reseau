#!/bin/sh
### BEGIN INIT INFO
# Provides:          route.sh
### END INIT INFO

if [ -f /bin/setupcon ]; then
    case "$1" in
        stop|status)
        	route del -net 200.3.6.0 netmask 255.255.255.0 gw 192.168.0.6
		route del -net 200.3.2.0 netmask 255.255.255.0 gw 192.168.0.2
		route del -net 200.3.4.0 netmask 255.255.255.0 gw 192.168.0.4
		route del -net 200.3.5.0 netmask 255.255.255.0 gw 192.168.0.5
		route del -net 200.3.7.0 netmask 255.255.255.0 gw 192.168.0.7
		route del default gw 172.31.20.1
        ;;
        start|force-reload|restart|reload)
		echo 1 > /proc/sys/net/ipv4/ip_forward

		route add -net 200.3.6.0 netmask 255.255.255.0 gw 192.168.0.6
		route add -net 200.3.2.0 netmask 255.255.255.0 gw 192.168.0.2
		route add -net 200.3.4.0 netmask 255.255.255.0 gw 192.168.0.4
		route add -net 200.3.5.0 netmask 255.255.255.0 gw 192.168.0.5
		route add -net 200.3.7.0 netmask 255.255.255.0 gw 192.168.0.7
		route add default gw 172.31.20.1    

	;;
        *)
            echo 'Usage: /etc/init.d/route.sh {start|reload|restart|force-reload|stop|status}'
            exit 3
            ;;
    esac
fi
