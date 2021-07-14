#!/bin/bash
echo " ++++++++++++++++++++++++++++++"
echo "++                            ++"
echo "++  Essential Linux Packages  ++"
echo "++        By Arpan Sen        ++"
echo "++                            ++"
echo " ++++++++++++++++++++++++++++++"
echo
echo "This package will install and pre-configure NodeJS v12"
echo "Setup will begin in 5 seconds, Press Ctrl + C to stop."
sleep 5s

echo Starting Installation
echo Updating Package Repositories
apt update

echo Install NodeJs
curl -sL https://deb.nodesource.com/setup_12.x | bash -
apt install nodejs -y
apt install build-essential -y

echo "Installation Finished Successfully!"
