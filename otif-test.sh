#!/bin/sh

# This script aims at showing status for OTIF 16.x services
# Martin Brousseau (November 3rd 2017)

case "$1" in

    'services')
        # Test Services
        systemctl status postgresql-9.4 mongod ot-zk-1 kafka infofusion-web-crawling-1 otif-wsm-cra$
        ;;

    'ports')
        # Test if services are listening on default ports
        echo "*** PostgreSQL on port 5432" && ss -ntlup | grep 5432
        echo "*** MongoDB on port 27017" && ss -ntlup | grep 27017
        echo "*** Zookeeper on port 2181" && ss -ntlup | grep 2181
        echo "*** Kafka on port 9092" && ss -ntlup | grep 9092
        echo "*** WSM Crawler on port 10010" && ss -ntlup | grep 10010
        echo "*** Web Crawler on port 10011" && ss -ntlup | grep 10011
        ;;


  *)
        echo "Usage: $0 { services | ports }"
        echo ""
        echo "Commands:"
        echo "  services: Show status for all OTIF services."
        echo "  ports: Show if services are listening on default ports."
        exit 1
        ;;
esac
