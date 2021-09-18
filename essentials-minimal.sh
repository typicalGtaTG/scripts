#!/bin/bash
echo " ++++++++++++++++++++++++++++++"
echo "++                            ++"
echo "++  Essential Linux Packages  ++"
echo "++        By Arpan Sen        ++"
echo "++                            ++"
echo " ++++++++++++++++++++++++++++++"
echo
echo "This package will install and pre-configure the following linux packages and tools:"
echo -e "lsof \n Wget \n Curl \n nano \n git \n htop"
echo "Setup will begin in 5 seconds, Press Ctrl + C to stop."
sleep 5s

echo Starting Installation
echo Updating Package Repositories and Applications
apt update && apt upgrade -y

echo Installing Curl, Wget, nano, git and htop
apt-get install wget curl nano lsof git htop -y

echo "Installation Finished Successfully!"
