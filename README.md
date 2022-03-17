# CosmoKit
 Scripts & tools for building & configuring Cosmos ecosystem nodes

 ## About

This toolkit is a collection of scripts, tips, & utilities that I've found useful during my time as a Cosmos ecosystem node operator.

Hopefully, you find some of these tools useful, too. :)

## Scripts:

### 1. setup_ufw_fail2ban.sh

A simple script to automate the process of installing **UFW** and configuring some basic rules/ports for **Tendermint-based chains**:
- allow outgoing
- deny incoming
- allow ssh/tcp
- limit ssh/tcp
- allow 26656 (Cosmos peers)
- allow 26657 (RPC port)
- allow 9093 (we've configured this port for Prometheus, instead of port 9090)
- allow 16524/tcp (new SSH)
- limit 16524/tcp
- deny 22/tcp (default SSH)
- allow 1317 (LCD port)

The same script also includes the installation of **Fail2Ban**, a simple way to automatically ban IPs that are attempting to spam/bruteforce your server.

### 2. install_prometheus.sh

Pretty self explanatory. This script will run through the necessary setup steps required to isntall prometheus, as well as node_exporter_full, which are great for exporting node data directly to Grafana servers. 

Note: this script is configured for **port 9093** instead of the default port 9090.
