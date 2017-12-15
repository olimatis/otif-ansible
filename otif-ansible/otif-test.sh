#!/bin/sh

# This script aims at showing status for OTIF services running locally


case "$1" in

    'services')
        # Test Services
        systemctl status postgresql-9.4 mongod ot-zk-1 kafka infofusion-web-crawling-1 otif-wsm-crawler-1 otif-ingestion-api-1 otif-text-mining| grep -E '●|Active'
        ;;

    'ports')
        # Test if services are listening on default ports
        echo "*** PostgreSQL on port 5432" && ss -ntlup | grep 5432
        echo "*** MongoDB on port 27017" && ss -ntlup | grep 27017
        echo "*** Zookeeper on port 2181" && ss -ntlup | grep 2181
        echo "*** Kafka on port 9092" && ss -ntlup | grep 9092
        echo "*** WSM Crawler on port 10010" && ss -ntlup | grep 10010
        echo "*** Web Crawler on port 10011" && ss -ntlup | grep 10011
        echo "*** Ingestion Pipeline API on port 7071" && ss -ntlup | grep 7071
        echo "*** Ingestion Pipeline Admin API on port 7171" && ss -ntlup | grep 7171
        echo "*** Text Mining Engine on port 40002" && ss -ntlup | grep 40002
        ;;


  *)
        echo "This script aims at showing status for OTIF services running locally."
        echo "Usage: $0 { services | ports }"
        echo ""
        echo "Commands:"
        echo "  services: Show status for all OTIF services runing locally."
        echo "  ports: Show if services are listening on default ports."
        exit 1
        ;;
esac
