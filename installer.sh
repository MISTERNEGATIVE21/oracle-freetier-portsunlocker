#!/bin/bash

# Function to display ASCII art intro
display_intro() {
    clear
 cat << "EOF"
 /$$$$$$$                                          /$$         /$$                                         /$$                
| $$__  $$                                        | $$        | $$                                        | $$                
| $$  \ $$  /$$$$$$   /$$$$$$  /$$   /$$  /$$$$$$ | $$$$$$$  /$$$$$$   /$$   /$$  /$$$$$$  /$$   /$$      | $$$$$$$  /$$   /$$
| $$$$$$$/ /$$__  $$ /$$__  $$| $$  | $$ /$$__  $$| $$__  $$|_  $$_/  | $$  | $$ /$$__  $$| $$  | $$      | $$__  $$| $$  | $$
| $$__  $$| $$  \__/| $$  \ $$| $$  | $$| $$  \ $$| $$  \ $$  | $$    | $$  | $$| $$  \ $$| $$  | $$      | $$  \ $$| $$  | $$
| $$  \ $$| $$      | $$  | $$| $$  | $$| $$  | $$| $$  | $$  | $$ /$$| $$  | $$| $$  | $$| $$  | $$      | $$  | $$| $$  | $$
| $$$$$$$/| $$      |  $$$$$$/|  $$$$$$/|  $$$$$$$| $$  | $$  |  $$$$/|  $$$$$$$|  $$$$$$/|  $$$$$$/      | $$$$$$$/|  $$$$$$$
|_______/ |__/       \______/  \______/  \____  $$|__/  |__/   \___/   \____  $$ \______/  \______/       |_______/  \____  $$
                                         /$$  \ $$                     /$$  | $$                                     /$$  | $$
                                        |  $$$$$$/                    |  $$$$$$/                                    |  $$$$$$/
                                         \______/                      \______/                                      \______/ 
EOF
    cat << "EOF"
 ___ __ __    ________  ______   _________  ______   ______        ___   __    ______   _______    ________   _________  ________  __   __   ______      
/__//_//_/\  /_______/\/_____/\ /________/\/_____/\ /_____/\      /__/\ /__/\ /_____/\ /______/\  /_______/\ /________/\/_______/\/_/\ /_/\ /_____/\     
\::\| \| \ \ \__.::._\/\::::_\/_\__.::.__\/\::::_\/_\:::_ \ \     \::\_\\  \ \\::::_\/_\::::__\/__\::: _  \ \\__.::.__\/\__.::._\/\:\ \\ \ \\::::_\/_    
 \:.      \ \   \::\ \  \:\/___/\  \::\ \   \:\/___/\\:(_) ) )_    \:. `-\  \ \\:\/___/\\:\ /____/\\::(_)  \ \  \::\ \     \::\ \  \:\ \\ \ \\:\/___/\   
  \:.\-/\  \ \  _\::\ \__\_::._\:\  \::\ \   \::___\/_\: __ `\ \    \:. _    \ \\::___\/_\:\\_  _\/ \:: __  \ \  \::\ \    _\::\ \__\:\_/.:\ \\::___\/_  
   \. \  \  \ \/__\::\__/\ /____\:\  \::\ \   \:\____/\\ \ `\ \ \    \. \`-\  \ \\:\____/\\:\_\ \ \  \:.\ \  \ \  \::\ \  /__\::\__/\\ ..::/ / \:\____/\ 
    \__\/ \__\/\________\/ \_____\/   \__\/    \_____\/ \_\/ \_\/     \__\/ \__\/ \_____\/ \_____\/   \__\/\__\/   \__\/  \________\/ \___/_(   \_____\/ 
EOF
}

# Call the function to display the intro
display_intro

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

# Function to install CasaOS
install_casaos() {
    curl -fsSL https://get.casaos.io | sudo bash
}

# Function to install CloudPanel
install_cloudpanel() {
    curl -fsSL https://installer.cloudpanel.io | sudo bash
}

# Function to install aaPanel
install_aapanel() {
    curl -sSO https://www.aapanel.com/script/aapanel_installer.sh
    sudo bash aapanel_installer.sh
}

# Function to install Webmin
install_webmin() {
    if [ "$OS" = "ubuntu" ] || [ "$OS" = "debian" ]; then
        wget -qO- https://prdownloads.sourceforge.net/webadmin/webmin_1.979_all.deb > webmin.deb
        sudo dpkg --install webmin.deb
        sudo apt-get -f install -y
    elif [ "$OS" = "centos" ] || [ "$OS" = "rhel" ] || [ "$OS" = "fedora" ]; then
        wget -qO- http://prdownloads.sourceforge.net/webadmin/webmin-1.979-1.noarch.rpm > webmin.rpm
        sudo yum localinstall -y webmin.rpm
    else
        echo "Unsupported OS for Webmin installation."
        exit 1
    fi
}

# Function to install ISPConfig
install_ispconfig() {
    curl -fsSL https://www.ispconfig.org/downloads/ISPConfig-3-stable.tar.gz -o ispconfig.tar.gz
    tar xzf ispconfig.tar.gz
    cd ispconfig3_install/install/
    sudo php -q install.php
}

# Function to install Froxlor
install_froxlor() {
    if [ "$OS" = "ubuntu" ] || [ "$OS" = "debian" ]; then
        sudo apt-get update
        sudo apt-get install -y wget lsb-release
        wget -O - https://files.froxlor.org/debian/froxlor.gpg | sudo apt-key add -
        echo "deb http://packages.froxlor.org/debian/ $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/froxlor.list
        sudo apt-get update
        sudo apt-get install -y froxlor
    elif [ "$OS" = "centos" ] || [ "$OS" = "rhel" ]; then
        sudo yum install -y epel-release
        sudo yum install -y wget
        wget -O /etc/yum.repos.d/froxlor.repo https://packages.froxlor.org/rpm/froxlor.repo
        sudo yum install -y froxlor
    else
        echo "Unsupported OS for Froxlor installation."
        exit 1
    fi
}

# Function to display the menu and handle user selection
display_menu() {
    while true; do
        echo "Select a web panel to install:"
        echo "1. CasaOS"
        echo "2. CloudPanel"
        echo "3. aaPanel"
        echo "4. Webmin"
        echo "5. ISPConfig"
        echo "6. Froxlor"
        echo "7. Exit"
        read -p "Enter your choice [1-7]: " choice

        case $choice in
            1)
                echo "CasaOS is selected."
                install_casaos
                ;;
            2)
                echo "CloudPanel is selected."
                install_cloudpanel
                ;;
            3)
                echo "aaPanel is selected."
                install_aapanel
                ;;
            4)
                echo "Webmin is selected."
                install_webmin
                ;;
            5)
                echo "ISPConfig is selected."
                install_ispconfig
                ;;
            6)
                echo "Froxlor is selected."
                install_froxlor
                ;;
            7)
                echo "Exiting..."
                exit 0
                ;;
            *)
                echo "Invalid option. Please select a number between 1 and 7."
                ;;
        esac
    done
}

# Display the menu and handle user selection
display_menu

echo "Script execution completed."
