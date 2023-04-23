#!/bin/bash
echo " ++++++++++++++++++++++++++++++"
echo "++                            ++"
echo "++  Essential Linux Packages  ++"
echo "++        By Arpan Sen        ++"
echo "++                            ++"
echo " ++++++++++++++++++++++++++++++"
echo
echo "This package will install and pre-configure the following linux packages and tools:"
echo -e "Speedtest (Official) \n Wget \n Curl \n nano \n git \n NodeJs \n htop"
echo "Setup will begin in 10 seconds, Press Ctrl + C to stop."
sleep 10s

echo Starting Installation
echo Updating Package Repositories and Applications
apt update && apt upgrade -y

echo Installing Curl, Wget, nano, git and htop
apt-get install wget curl nano lsof git htop -y

echo Installing SpeedTest Official
curl -s https://install.speedtest.net/app/cli/install.deb.sh | bash
apt-get install speedtest -y

echo Install NodeJs
curl -sL https://deb.nodesource.com/setup_18.x | bash -
apt install nodejs -y
apt install build-essential -y

echo "Installation Finished Successfully!"
