#!/bin/bash

# Variables
RED='\033[0;41;30m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
STD='\033[0;0;39m'

# ASCII Art Function
display_ascii_art() {
    echo -e "${YELLOW}"
    echo "▒█████  ██▀███  ▄▄▄      ▄████▄  ██▓   ▓█████     ██▓███  ▒█████  ██▀███ ▄▄▄█████▓ ██████     █    ██ ███▄    █ ██▓    ▒█████  ▄████▄  ██ ▄█▓█████ ██▀███ "
    echo "▒██▒  ██▓██ ▒ ██▒████▄   ▒██▀ ▀█ ▓██▒   ▓█   ▀    ▓██░  ██▒██▒  ██▓██ ▒ ██▓  ██▒ ▓▒██    ▒     ██  ▓██▒██ ▀█   █▓██▒   ▒██▒  ██▒██▀ ▀█  ██▄█▒▓█   ▀▓██ ▒ ██▒"
    echo "▒██░  ██▓██ ░▄█ ▒██  ▀█▄ ▒▓█    ▄▒██░   ▒███      ▓██░ ██▓▒██░  ██▓██ ░▄█ ▒ ▓██░ ▒░ ▓██▄      ▓██  ▒██▓██  ▀█ ██▒██░   ▒██░  ██▒▓█    ▄▓███▄░▒███  ▓██ ░▄█ ▒"
    echo "▒██   ██▒██▀▀█▄ ░██▄▄▄▄██▒▓▓▄ ▄██▒██░   ▒▓█  ▄    ▒██▄█▓▒ ▒██   ██▒██▀▀█▄ ░ ▓██▓ ░  ▒   ██▒   ▓▓█  ░██▓██▒  ▐▌██▒██░   ▒██   ██▒▓▓▄ ▄██▓██ █▄▒▓█  ▄▒██▀▀█▄"
    echo "░ ████▓▒░██▓ ▒██▒▓█   ▓██▒ ▓███▀ ░██████░▒████▒   ▒██▒ ░  ░ ████▓▒░██▓ ▒██▒ ▒██▒ ░▒██████▒▒   ▒▒█████▓▒██░   ▓██░██████░ ████▓▒▒ ▓███▀ ▒██▒ █░▒████░██▓ ▒██▒"
    echo "░ ▒░▒░▒░░ ▒▓ ░▒▓░▒▒   ▓▒█░ ░▒ ▒  ░ ▒░▓  ░░ ▒░ ░   ▒▓▒░ ░  ░ ▒░▒░▒░░ ▒▓ ░▒▓░ ▒ ░░  ▒ ▒▓▒ ▒ ░   ░▒▓▒ ▒ ▒░ ▒░   ▒ ▒░ ▒░▓  ░ ▒░▒░▒░░ ░▒ ▒  ▒ ▒▒ ▓░░ ▒░ ░ ▒▓ ░▒▓░"
    echo "  ░ ▒ ▒░  ░▒ ░ ▒░ ▒   ▒▒ ░ ░  ▒  ░ ░ ▒  ░░ ░  ░   ░▒ ░      ░ ▒ ▒░  ░▒ ░ ▒░   ░   ░ ░▒  ░ ░   ░░▒░ ░ ░░ ░░   ░ ▒░ ░ ▒  ░ ░ ▒ ▒░  ░  ▒  ░ ░▒ ▒░░ ░  ░ ░▒ ░ ▒░"
    echo "░ ░ ░ ▒   ░░   ░  ░   ▒  ░         ░ ░     ░      ░░      ░ ░ ░ ▒   ░░   ░  ░     ░  ░  ░      ░░░ ░ ░   ░   ░ ░  ░ ░  ░ ░ ░ ▒ ░       ░ ░░ ░   ░    ░░   ░ "
    echo "    ░ ░    ░          ░  ░ ░         ░  ░   ░  ░                ░ ░    ░                ░         ░           ░    ░  ░   ░ ░ ░     ░  ░     ░  ░  ░     "
    echo "                         ░                                                                                              ░                                    "
    echo
    echo "███▄ ▄███▓██▓ ██████▄▄▄█████▓█████ ██▀███      ███▄    █▓█████  ▄████ ▄▄▄    ▄▄▄█████▓██▓██▒   █▓█████ "
    echo "▓██▒▀█▀ ██▓██▒██    ▒▓  ██▒ ▓▓█   ▀▓██ ▒ ██▒    ██ ▀█   █▓█   ▀ ██▒ ▀█▒████▄  ▓  ██▒ ▓▓██▓██░   █▓█   ▀ "
    echo "▓██    ▓██▒██░ ▓██▄  ▒ ▓██░ ▒▒███  ▓██ ░▄█ ▒   ▓██  ▀█ ██▒███  ▒██░▄▄▄▒██  ▀█▄▒ ▓██░ ▒▒██▒▓██  █▒▒███   "
    echo "▒██    ▒██░██░ ▒   ██░ ▓██▓ ░▒▓█  ▄▒██▀▀█▄     ▓██▒  ▐▌██▒▓█  ▄░▓█  ██░██▄▄▄▄█░ ▓██▓ ░░██░ ▒██ █░▒▓█  ▄ "
    echo "▒██▒   ░██░██▒██████▒▒ ▒██▒ ░░▒████░██▓ ▒██▒   ▒██░   ▓██░▒████░▒▓███▀ ▒▓█   ▓██▒▒██▒ ░░██░  ▒▀█░ ░▒████▒"
    echo "░ ▒░   ░  ░▓ ▒ ▒▓▒ ▒ ░ ▒ ░░  ░░ ▒░ ░ ▒▓ ░▒▓░   ░ ▒░   ▒ ▒░░ ▒░ ░░▒   ▒ ▒▒   ▓▒█░▒ ░░  ░▓    ░ ▐░ ░░ ▒░ ░"
    echo "░  ░      ░▒ ░ ░▒  ░ ░   ░    ░ ░  ░ ░▒ ░ ▒░   ░ ░░   ░ ▒░░ ░  ░ ░   ░  ▒   ▒▒ ░  ░    ▒ ░  ░ ░░  ░ ░  ░"
    echo "░      ░   ▒ ░  ░  ░   ░        ░    ░░   ░       ░   ░ ░   ░  ░ ░   ░  ░   ▒   ░      ▒ ░    ░░    ░   "
    echo "       ░   ░       ░            ░  ░  ░                 ░   ░  ░     ░      ░  ░       ░       ░    ░  ░"
    echo "                                                                                               ░        "
    echo -e "${STD}"
}

reset_iptables() {
    echo -e "${YELLOW}Resetting iptables rules...${STD}"
    
    # Check if running as root
    if [ "$EUID" -ne 0 ]; then 
        echo -e "${RED}Please run as root${STD}"
        return
    fi
    
    # Apply iptables rules
    iptables -P INPUT ACCEPT
    iptables -P OUTPUT ACCEPT
    iptables -P FORWARD ACCEPT
    iptables -F
    
    echo -e "${GREEN}iptables rules have been reset. All traffic is now accepted.${STD}"
    echo -e "${YELLOW}Warning: This configuration leaves your system open. Use with caution.${STD}"
}

setup_firewall() {
    echo -e "${YELLOW}Checking OS and setting up firewall...${STD}"
    
    # Check if running as root
    if [ "$EUID" -ne 0 ]; then 
        echo -e "${RED}Please run as root${STD}"
        return
    fi
    
    # Detect OS
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        OS=$NAME
    else
        echo -e "${RED}Unable to detect OS${STD}"
        return
    fi
    
    echo -e "${GREEN}Detected OS: $OS${STD}"
    
    # Save and flush iptables rules
    echo -e "${YELLOW}Saving current iptables rules...${STD}"
    sudo iptables-save > ~/iptables-rules
    echo -e "${YELLOW}Flushing iptables rules...${STD}"
    sudo iptables --flush
    
    # Install and configure firewall based on OS
    case "$OS" in
        "Ubuntu"|"Debian GNU/Linux")
            if ! command -v ufw &> /dev/null; then
                echo -e "${YELLOW}Installing UFW...${STD}"
                apt-get update
                apt-get install -y ufw
            fi
            echo -e "${YELLOW}Configuring UFW...${STD}"
            ufw default allow outgoing
            ufw default allow incoming
            ufw allow 80/tcp
            ufw --force enable
            echo -e "${GREEN}UFW configured and enabled${STD}"
            ;;
        "CentOS Linux"|"Red Hat Enterprise Linux"|"Fedora")
            if ! command -v firewall-cmd &> /dev/null; then
                echo -e "${YELLOW}Installing firewalld...${STD}"
                yum install -y firewalld
                systemctl start firewalld
                systemctl enable firewalld
            fi
            echo -e "${YELLOW}Configuring firewalld...${STD}"
            firewall-cmd --zone=public --add-interface=eth0 --permanent
            firewall-cmd --set-default-zone=public
            firewall-cmd --zone=public --add-service=http --permanent
            firewall-cmd --zone=public --add-port=1-65535/tcp --permanent
            firewall-cmd --zone=public --add-port=1-65535/udp --permanent
            firewall-cmd --reload
            echo -e "${GREEN}firewalld configured and enabled${STD}"
            ;;
        *)
            echo -e "${RED}Unsupported OS for automatic firewall configuration${STD}"
            return
            ;;
    esac
    
    echo -e "${GREEN}Firewall setup complete. All ports are now open and port 80 is specifically allowed.${STD}"
    echo -e "${YELLOW}Warning: Opening all ports can be a security risk. Please configure your firewall rules carefully for production use.${STD}"
}

# Function to display the options
display_options() {
    echo -e "${GREEN}Web Hosting Panel Installation Options${STD}"
    echo "---------------------------------------"
    echo "1. Install CloudPanel"
    echo "2. Install CyberPanel"
    echo "3. Install CASA Panel"
    echo "4. Install Froxlor"
    echo "5. Install aaPanel"
    echo "6. Install Webmin"
    echo "7. Install Virtualmin"
    echo "8. Reset iptables"
    echo "9. Exit"
    echo
}

# Main script
clear
display_ascii_art

while true; do
    display_options
    read -p "Enter your choice [1-9]: " choice

    case $choice in
        1) install_cloudpanel ;;
        2) install_cyberpanel ;;
        3) install_casa ;;
        4) install_froxlor ;;
        5) install_aapanel ;;
        6) install_webmin ;;
        7) install_virtualmin ;;
        8) reset_iptables ;;
        9) echo -e "${GREEN}Exiting...${STD}"; exit 0 ;;
        *) echo -e "${RED}Invalid option. Please select a valid option.${STD}" ;;
    esac
done

# Run firewall setup (not part of the menu-driven program)
setup_firewall
