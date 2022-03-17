#!/bin/zsh

useradd --no-create-home --shell /bin/false prometheus
useradd --no-create-home --shell /bin/false node_exporter

mkdir /etc/prometheus
mkdir /var/lib/prometheus

chown prometheus:prometheus /etc/prometheus
chown prometheus:prometheus /var/lib/prometheus

wget https://github.com/prometheus/node_exporter/releases/download/v1.2.2/node_exporter-1.2.2.linux-amd64.tar.gz
tar xvf node_exporter-1.2.2.linux-amd64.tar.gz

cp node_exporter-1.2.2.linux-amd64/node_exporter /usr/local/bin
chown node_exporter:node_exporter /usr/local/bin/node_exporter
rm -rf node_exporter-1.2.2.linux-amd64.tar.gz node_exporter-1.2.2.linux-amd64

echo "
[Unit]
Description=Node Exporter
Wants=network-online.target
After=network-online.target

[Service]
User=node_exporter
Group=node_exporter
Type=simple
ExecStart=/usr/local/bin/node_exporter

[Install]
WantedBy=multi-user.target
" >> /etc/systemd/system/node_exporter.service

systemctl daemon-reload
systemctl start node_exporter
systemctl enable node_exporter

apt-get update && sudo apt-get upgrade -y
wget https://github.com/prometheus/prometheus/releases/download/v2.31.1/prometheus-2.31.1.linux-amd64.tar.gz
tar xfz prometheus-2.31.1.linux-amd64.tar.gz

PROMETHEUS_DIR=prometheus-2.31.1.linux-amd64
cp $PROMETHEUS_DIR/prometheus /usr/local/bin/
cp $PROMETHEUS_DIR/promtool /usr/local/bin/

chown prometheus:prometheus /usr/local/bin/prometheus
chown prometheus:prometheus /usr/local/bin/promtool

cp -r $PROMETHEUS_DIR/consoles /etc/prometheus
cp -r $PROMETHEUS_DIR/console_libraries /etc/prometheus

chown -R prometheus:prometheus /etc/prometheus/consoles
chown -R prometheus:prometheus /etc/prometheus/console_libraries

rm -rf $PROMETHEUS_DIR prometheus-2.31.1.linux-amd64.tar.gz
