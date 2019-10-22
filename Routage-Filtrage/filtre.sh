#!/bin/sh
### BEGIN INIT INFO
# Provides:          route.sh
### END INIT INFO

if [ -f /bin/setupcon ]; then
    case "$1" in
        stop|status)
        	iptables -X
		iptables -F

		iptables -P INPUT ACCEPT
		iptables -P OUTPUT ACCEPT
		iptables -P FORWARD ACCEPT
        ;;
        start|force-reload|restart|reload)
		echo 1 > /proc/sys/net/ipv4/ip_forward

		#Supprimer les règles pré-existantes
		iptables -X
		iptables -F

		#Autoriser l'interface loopback
		iptables -A INPUT -i lo -j ACCEPT
		iptables -A OUTPUT -i lo -j ACCEPT

		#Définir la politique par défaut
		iptables -P INPUT DROP
		iptables -P OUTPUT DROP
		iptables -P FORWARD DROP

		#Bloquer l'accès d un autre groupe à notre serveur
		iptables -A INPUT -s 192.168.0.2 -j DROP

		#Sécuriser le serveur en ouvrant les ports strictement nécessaires
		iptables -A INPUT -p tcp --dport 80 -j ACCEPT
		iptables -A INPUT -p tcp --dport 443 -j ACCEPT
		iptables -A INPUT -p tcp --dport 53 -j ACCEPT
		iptables -A INPUT -p udp --dport 53 -j ACCEPT
		iptables -A INPUT -p tcp --dport 22 -j ACCEPT
		iptables -A INPUT -p tcp --dport 389 -j ACCEPT
		iptables -A INPUT -p icmp -j ACCEPT
		iptables -A OUTPUT -p tcp --dport 80 -j ACCEPT
		iptables -A OUTPUT -p tcp --dport 443 -j ACCEPT
		iptables -A OUTPUT -p tcp --dport 53 -j ACCEPT
		iptables -A OUTPUT -p udp --dport 53 -j ACCEPT
		iptables -A OUTPUT -p tcp --dport 22 -j ACCEPT
		iptables -A OUTPUT -p tcp --dport 389 -j ACCEPT
		iptables -A OUTPUT -p icmp -j ACCEPT

		#Permettre le dialogue entre le client et le serveur
		iptables -A INPUT -s 200.3.3.0/24 -j ACCEPT
		iptables -A OUTPUT -d 200.3.3.0/24 -j ACCEPT

		#Sécuriser le client en ouvrant les ports strictement nécessaires
		iptables -A FORWARD -p tcp --dport 80 -j ACCEPT
		iptables -A FORWARD -p tcp --dport 443 -j ACCEPT
		iptables -A FORWARD -p tcp --dport 53 -j ACCEPT
		iptables -A FORWARD -p udp --dport 53 -j ACCEPT
		iptables -A FORWARD -p icmp -j ACCEPT

		#On accepte les réponses
		iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
		iptables -A FORWARD -m state --state ESTABLISHED,RELATED -j ACCEPT

		#NAT
		iptables -t nat -A POSTROUTING -s 200.3.3.0/24 -j MASQUERADE

	;;
        *)
            echo 'Usage: /etc/init.d/route.sh {start|reload|restart|force-reload|stop|status}'
            exit 3
            ;;
    esac
fi
