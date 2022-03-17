#!/bin/zsh

# install UFW & port rules

apt-get install ufw -y

ufw default allow outgoing
ufw default deny incoming
ufw allow ssh/tcp
ufw limit ssh/tcp
ufw allow 26656
ufw allow 26657
ufw allow 9093
ufw allow 16524/tcp
ufw limit 16524/tcp
ufw deny 22/tcp
ufw allow 1317
ufw enable -y

# install fail2ban

apt-get install fail2ban -y

cp /etc/fail2ban/jail.{conf,local}
