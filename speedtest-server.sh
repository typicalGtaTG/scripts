#!/bin/bash

install_speedtest_server() {
    echo "Installing Speedtest Server"
    wget https://install.speedtest.net/ooklaserver/ooklaserver.sh
    chmod a+x ooklaserver.sh
    ./ooklaserver.sh install
}

configure_rc_local() {
    echo "Configuring rc.local"

    if [ ! -f "/etc/systemd/system/rc-local.service" ]; then
        touch /etc/systemd/system/rc-local.service
        echo "[Unit]" >> /etc/systemd/system/rc-local.service
        echo "Description=/etc/rc.local" >> /etc/systemd/system/rc-local.service
        echo "ConditionPathExists=/etc/rc.local" >> /etc/systemd/system/rc-local.service
        echo "[Service]" >> /etc/systemd/system/rc-local.service
        echo "Type=forking" >> /etc/systemd/system/rc-local.service
        echo "ExecStart=/etc/rc.local start" >> /etc/systemd/system/rc-local.service
        echo "TimeoutSec=0" >> /etc/systemd/system/rc-local.service
        echo "StandardOutput=tty" >> /etc/systemd/system/rc-local.service
        echo "RemainAfterExit=yes" >> /etc/systemd/system/rc-local.service
        echo "SysVStartPriority=99" >> /etc/systemd/system/rc-local.service
        echo "[Install]" >> /etc/systemd/system/rc-local.service
        echo "WantedBy=multi-user.target" >> /etc/systemd/system/rc-local.service
    fi

    if [ ! -f "/etc/rc.local" ]; then
        touch /etc/rc.local
        echo "#!/bin/sh -e" >> /etc/rc.local
        echo "#" >> /etc/rc.local
        echo "# rc.local" >> /etc/rc.local
        echo "#" >> /etc/rc.local
        echo "# This script is executed at the end of each multiuser runlevel." >> /etc/rc.local
        echo "# Make sure that the script will "exit 0" on success or any other" >> /etc/rc.local
        echo "# value on error." >> /etc/rc.local
        echo "#" >> /etc/rc.local
        echo "# In order to enable or disable this script just change the execution" >> /etc/rc.local
        echo "# bits." >> /etc/rc.local
        echo "#" >> /etc/rc.local
        echo "# By default this script does nothing." >> /etc/rc.local
        echo "exit 0" >> /etc/rc.local
        chmod +x /etc/rc.local
    else
        sed -i '$i su root -c '/root/OoklaServer --daemon'' /etc/rc.local
    fi

    systemctl enable --now rc-local
}

echo "Welcome to Speedtest Server installer by Arpan S."
echo "This script must be run on a system under the root user."

echo "Checking if script is run by root"
if [ "$(whoami)" != "root" ]; then
    echo "Script must be run as root"
    exit 255
fi

install_speedtest_server
configure_rc_local
echo "Installation and configuration completed successfully."
