#!/bin/bash
#Alan's Docker Prometheus Setup
#Version 0.0.1
#Date 3/30/2021
my_ip=$(ip route get 8.8.8.8 | awk -F"src " 'NR==1{split($2,a," ");print a[1]}')
git clone https://github.com/stefanprodan/dockprom
cd dockprom

ADMIN_USER=admin ADMIN_PASSWORD=admin ADMIN_PASSWORD_HASH=JDJhJDE0JE91S1FrN0Z0VEsyWmhrQVpON1VzdHVLSDkyWHdsN0xNbEZYdnNIZm1pb2d1blg4Y09mL0ZP docker-compose up -d


echo Containers Created: 
echo " "
echo " "
echo Prometheus (metrics database) http://$my_ip:9090
echo Prometheus-Pushgateway (push acceptor for ephemeral and batch jobs) http://$my_ip:9091
echo AlertManager (alerts management) http://$my_ip:9093
echo Grafana (visualize metrics) http://$my_ip:3000
echo NodeExporter (host metrics collector)
echo cAdvisor (containers metrics collector)
echo Caddy (reverse proxy and basic auth provider for prometheus and alertmanager)
