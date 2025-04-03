# Vorraussetzungen

* Ein funktionierender Server mit docker und ubuntu
* Zugriff auf den Server via SSH (Security Groups)

--

ssh port forward auf floating ip

mkdir /etc/prometheus

copy docker-compose zum Server

copy prom config nach ll /etc/prometheus/prometheus.yaml

❯ ssh 78.138.70.124 -l ubuntu -L 3000:localhost:3000 -L 9090:localhost:9090

openstack loadbalancer create --name testlb --vip-subnet-id p500884-mvorwerk-subnet --wait

$ openstack loadbalancer listener create --name stats-listener --protocol PROMETHEUS --protocol-port 8088 testlb

Import Dashboard
https://grafana.com/grafana/dashboards/15828-openstack-octavia-amphora-load-balancer/
