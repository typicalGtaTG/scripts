#!/bin/bash
echo " ++++++++++++++++++++++++++++++"
echo "++                            ++"
echo "++     DNS Automatic Deploy   ++"
echo "++       By SNDC Pvt. Ltd.    ++"
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
apt-get install wget curl nano lsof git htop sudo -y

echo "Installing DNS Solution"
curl -sSL https://raw.githubusercontent.com/AdguardTeam/AdGuardHome/master/scripts/install.sh | sh

echo "Installation Finished Successfully!"
echo "Thank you! For any queries, Contact us at: +91 7358083264. Script by SNDC Pvt. Ltd."
