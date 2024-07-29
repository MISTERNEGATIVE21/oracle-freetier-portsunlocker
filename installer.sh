#!/bin/bash

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Determine the OS and install firewalld if not installed
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$ID
else
    OS=$(uname -s)
fi

install_firewalld() {
    if [ "$OS" = "ubuntu" ] || [ "$OS" = "debian" ]; then
        sudo apt-get update
        sudo apt-get install -y firewalld
    elif [ "$OS" = "centos" ] || [ "$OS" = "rhel" ] || [ "$OS" = "fedora" ]; then
        sudo yum install -y firewalld
    else
        echo "Unsupported OS"
        exit 1
    fi
}

# Check if firewalld is installed, if not, install it
if ! command_exists firewalld; then
    echo "firewalld is not installed. Installing..."
    install_firewalld
else
    echo "firewalld is already installed."
fi

# Ensure firewalld is started and enabled
sudo systemctl start firewalld
sudo systemctl enable firewalld

# Flush existing iptables rules
sudo iptables -F
sudo iptables -X
sudo iptables -t nat -F
sudo iptables -t nat -X
sudo iptables -t mangle -F
sudo iptables -t mangle -X
sudo iptables -t raw -F
sudo iptables -t raw -X

# Set default policies to accept
sudo iptables -P INPUT ACCEPT
sudo iptables -P FORWARD ACCEPT
sudo iptables -P OUTPUT ACCEPT

# Save the iptables configuration
sudo iptables-save | sudo tee /etc/sysconfig/iptables

# Restart the firewalld service
sudo systemctl restart firewalld

# Open all TCP and UDP ports in firewalld
sudo firewall-cmd --zone=public --add-port=0-65535/tcp --permanent
sudo firewall-cmd --zone=public --add-port=0-65535/udp --permanent
sudo firewall-cmd --reload

# Install CasaOS
install_casaos() {
    curl -fsSL https://get.casaos.io | sudo bash
}

if ! command_exists casaos; then
    echo "CasaOS is not installed. Installing..."
    install_casaos
else
    echo "CasaOS is already installed."
fi

echo "iptables rules flushed, firewalld restarted, all ports opened, and CasaOS installed."
