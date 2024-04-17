#!/bin/bash
echo " ++++++++++++++++++++++++++++++"
echo "++                            ++"
echo "++     DNS Automatic Deploy   ++"
echo "++        By Arpan Sen        ++"
echo "++                            ++"
echo " ++++++++++++++++++++++++++++++"
echo
echo "This package will install and pre-configure the following linux packages and tools:"
echo -e "lsof \n Wget \n Curl \n nano \n git \n htop \n sudo \n DNS Server Solution"
echo "Setup will begin in 5 seconds, Press Ctrl + C to stop."
sleep 5s

echo Starting Installation
echo Updating Package Repositories and Applications
apt update && apt upgrade -y

echo Installing Curl, Wget, nano, git and htop
apt-get install wget curl nano lsof git htop -y

echo "Installing DNS Solution"
curl -s -S -L https://raw.githubusercontent.com/AdguardTeam/AdGuardHome/master/scripts/install.sh | sh -s -- -v
apt install unbound
wget https://www.internic.net/domain/named.root -qO- | sudo tee /var/lib/unbound/root.hints
sudo mkdir -p /etc/systemd/resolved.conf.d
touch /etc/systemd/resolved.conf.d/dns.conf
echo "[Resolve]" >> /etc/systemd/resolved.conf.d/dns.conf
echo "DNS=127.0.0.1" >> /etc/systemd/resolved.conf.d/dns.conf
echo "DNSStubListener=no" >> /etc/systemd/resolved.conf.d/dns.conf
sudo mv /etc/resolv.conf /etc/resolv.conf.backup
sudo ln -s /run/systemd/resolve/resolv.conf /etc/resolv.conf
sudo systemctl reload-or-restart systemd-resolved

touch /etc/unbound/unbound.conf.d/ddns.conf
echo "server:" >> /etc/unbound/unbound.conf.d/ddns.conf
echo "        verbosity: 0" >> /etc/unbound/unbound.conf.d/ddns.conf
echo "        interface: 127.0.0.1" >> /etc/unbound/unbound.conf.d/ddns.conf
echo "        port: 5443" >> /etc/unbound/unbound.conf.d/ddns.conf
echo "        do-ip4: yes" >> /etc/unbound/unbound.conf.d/ddns.conf
echo "        do-udp: yes" >> /etc/unbound/unbound.conf.d/ddns.conf
echo "        do-tcp: yes" >> /etc/unbound/unbound.conf.d/ddns.conf
echo "        do-ip6: no" >> /etc/unbound/unbound.conf.d/ddns.conf
echo "        prefer-ip6: no" >> /etc/unbound/unbound.conf.d/ddns.conf
echo "        harden-glue: yes" >> /etc/unbound/unbound.conf.d/ddns.conf
echo "        harden-dnssec-stripped: yes" >> /etc/unbound/unbound.conf.d/ddns.conf
echo "        use-caps-for-id: no" >> /etc/unbound/unbound.conf.d/ddns.conf
echo "        edns-buffer-size: 14400" >> /etc/unbound/unbound.conf.d/ddns.conf
echo "        prefetch: yes" >> /etc/unbound/unbound.conf.d/ddns.conf
echo "        num-threads: 8" >> /etc/unbound/unbound.conf.d/ddns.conf
echo "        so-rcvbuf: 1m" >> /etc/unbound/unbound.conf.d/ddns.conf
service unbound restart
sudo systemctl disable unbound-resolvconf.service
sudo systemctl stop unbound-resolvconf.service

echo "Installation Finished Successfully!"
echo "Thank you! For any queries, Contact us at: +1 (609)-800-0576. Script by Arpan Sen Internet Services, LLC."
