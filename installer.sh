#!/bin/bash

# Variables
RED='\033[0;41;30m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
STD='\033[0;0;39m'

# ASCII Art Function
display_ascii_art() {
    echo -e "${YELLOW}"
    echo -e "\033[0;33m"
    echo " ██████  ██████   █████   ██████ ██      ███████     ███████ ███████ ██████  ██    ██ ███████ ██████  "
    echo "██    ██ ██   ██ ██   ██ ██      ██      ██          ██      ██      ██   ██ ██    ██ ██      ██   ██ "
    echo "██    ██ ██████  ███████ ██      ██      █████       ███████ █████   ██████  ██    ██ █████   ██████  "
    echo "██    ██ ██   ██ ██   ██ ██      ██      ██               ██ ██      ██   ██  ██  ██  ██      ██   ██ "
    echo " ██████  ██   ██ ██   ██  ██████ ███████ ███████     ███████ ███████ ██   ██   ████   ███████ ██   ██ "
    echo "                                                                                                      "
    echo "                                                                                                      "
    echo "██████   ██████  ██████  ████████ ███████      ██████  ██████  ███████ ███    ██ ███████ ██████       "
    echo "██   ██ ██    ██ ██   ██    ██    ██          ██    ██ ██   ██ ██      ████   ██ ██      ██   ██      "
    echo "██████  ██    ██ ██████     ██    ███████     ██    ██ ██████  █████   ██ ██  ██ █████   ██████       "
    echo "██      ██    ██ ██   ██    ██         ██     ██    ██ ██      ██      ██  ██ ██ ██      ██   ██      "
    echo "██       ██████  ██   ██    ██    ███████      ██████  ██      ███████ ██   ████ ███████ ██   ██      "
    echo "                                                                                                      "
    echo "                                                                                                      "
    echo " +-+-+-+-+-+-+-+-+-+-+    +-+-+"
    echo "   |B|R|O|U|G|H|T|Y|O|U|    |B|Y|"
    echo " +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-++"
    echo " |M|I|S|T|E|R| |N|E|G|A|T|I|V|E| "
    echo " +-+-+-+-+-+-+ +-+-+-+-+-+-+-+-+ "
    echo -e "\033[0m"
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

install_cloudpanel() {
    echo -e "${YELLOW}Installing CloudPanel...${STD}"
    curl -sSL https://installer.cloudpanel.io/ce/v2/install.sh | sudo bash
}

install_ratpanel() {
    echo -e "${YELLOW}Installing RatPanel...${STD}"
    HAOZI_DL_URL="https://dl.cdn.haozi.net/panel"; curl -sSL -O ${HAOZI_DL_URL}/install_panel.sh && curl -sSL -O ${HAOZI_DL_URL}/install_panel.sh.checksum.txt && sha256sum -c install_panel.sh.checksum.txt && bash install_panel.sh || echo "Checksum Verification Failed, File May Have Been Tampered With, Operation Terminated"
}

install_casa() {
    echo -e "${YELLOW}Installing CASA Panel...${STD}"
    curl -fsSL https://get.casaos.io | sudo bash
    echo "CASA Panel installation script executed."
}

install_froxlor() {
    echo -e "${YELLOW}Installing Froxlor...${STD}"
    sudo apt-get update
    sudo apt-get install -y froxlor
}

install_aapanel() {
    echo -e "${YELLOW}Installing aaPanel...${STD}"
    curl -sSO http://www.aapanel.com/script/install-ubuntu_6.0_en.sh && sudo bash install-ubuntu_6.0_en.sh
}

install_webmin() {
    echo -e "${YELLOW}Installing Webmin...${STD}"
    wget -q http://www.webmin.com/download/deb/webmin-current.deb
    sudo dpkg --install webmin-current.deb
    sudo apt-get -f install
}

install_virtualmin() {
    echo -e "${YELLOW}Installing Virtualmin...${STD}"
    wget http://software.virtualmin.com/gpl/scripts/install.sh
    sudo /bin/sh install.sh
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

install_tailscale() {
    echo -e "${YELLOW}Installing Tailscale...${STD}"
    curl -fsSL https://tailscale.com/install.sh | sudo bash
    echo -e "${GREEN}Tailscale installed. Run 'sudo tailscale up' to configure and connect.${STD}"
}

install_web_utilities() {
    echo -e "${YELLOW}Installing additional web utilities (nginx, curl, wget, git)...${STD}"
    if [ -f /etc/debian_version ]; then
        sudo apt-get update
        sudo apt-get install -y nginx curl wget git
    elif [ -f /etc/redhat-release ]; then
        sudo yum install -y nginx curl wget git
    else
        echo -e "${RED}Unsupported OS for web utilities installation${STD}"
        return
    fi
    echo -e "${GREEN}Web utilities (nginx, curl, wget, git) installed successfully.${STD}"
}

# NEW FUNCTION: Setup Tailscale Exit Node with proper port configuration
setup_tailscale_exit_node() {
    echo -e "${YELLOW}Setting up Tailscale as Exit Node with Port Configuration...${STD}"
    
    # Check if running as root
    if [ "$EUID" -ne 0 ]; then 
        echo -e "${RED}Please run as root${STD}"
        return
    fi
    
    # Install Tailscale if not already installed
    if ! command -v tailscale &> /dev/null; then
        echo -e "${YELLOW}Installing Tailscale...${STD}"
        curl -fsSL https://tailscale.com/install.sh | sudo bash
    else
        echo -e "${GREEN}Tailscale already installed.${STD}"
    fi
    
    # Configure IP forwarding for both IPv4 and IPv6
    echo -e "${YELLOW}Enabling IP forwarding (critical for exit node functionality)...${STD}"
    
    echo 'net.ipv4.ip_forward = 1' | sudo tee -a /etc/sysctl.d/99-tailscale.conf
    echo 'net.ipv6.conf.all.forwarding = 1' | sudo tee -a /etc/sysctl.d/99-tailscale.conf
    sudo sysctl -p /etc/sysctl.d/99-tailscale.conf
    
    # Verify IP forwarding is enabled
    ip_forward=$(cat /proc/sys/net/ipv4/ip_forward)
    if [ "$ip_forward" != "1" ]; then
        echo -e "${RED}Warning: IP forwarding is not enabled. Trying alternative method...${STD}"
        echo 1 | sudo tee /proc/sys/net/ipv4/ip_forward
        ip_forward=$(cat /proc/sys/net/ipv4/ip_forward)
        if [ "$ip_forward" != "1" ]; then
            echo -e "${RED}Failed to enable IP forwarding. Exit node will not work.${STD}"
        else
            echo -e "${GREEN}IP forwarding successfully enabled.${STD}"
        fi
    else
        echo -e "${GREEN}IP forwarding successfully enabled.${STD}"
    fi
    
    # Configure NAT for Tailscale
    echo -e "${YELLOW}Configuring NAT for Tailscale...${STD}"
    
    # Get main interface
    MAIN_INTERFACE=$(ip route | grep default | awk '{print $5}')
    echo -e "${GREEN}Using ${MAIN_INTERFACE} as the main network interface${STD}"
    
    # Configure iptables rules for NAT
    sudo iptables -t nat -A POSTROUTING -o ${MAIN_INTERFACE} -j MASQUERADE
    sudo iptables -A FORWARD -i tailscale0 -j ACCEPT
    sudo iptables -A FORWARD -o tailscale0 -j ACCEPT
    
    # Make iptables rules persistent
    echo -e "${YELLOW}Making iptables rules persistent...${STD}"
    
    if command -v netfilter-persistent &> /dev/null; then
        sudo netfilter-persistent save
    elif command -v iptables-save &> /dev/null; then
        if [ -d "/etc/iptables" ]; then
            sudo iptables-save > /etc/iptables/rules.v4
        elif [ -d "/etc/sysconfig" ]; then
            sudo iptables-save > /etc/sysconfig/iptables
        else
            sudo mkdir -p /etc/iptables
            sudo iptables-save > /etc/iptables/rules.v4
            echo "#!/bin/sh" | sudo tee /etc/network/if-up.d/iptables
            echo "iptables-restore < /etc/iptables/rules.v4" | sudo tee -a /etc/network/if-up.d/iptables
            sudo chmod +x /etc/network/if-up.d/iptables
        fi
    fi
    
    # Configure firewall to allow Tailscale ports
    echo -e "${YELLOW}Opening required ports for Tailscale...${STD}"
    
    if command -v ufw &> /dev/null; then
        sudo ufw allow 41641/udp comment "Tailscale"
        sudo ufw allow 3478/udp comment "Tailscale STUN"
        sudo ufw allow 50000:51000/udp comment "Tailscale DERP range"
    elif command -v firewall-cmd &> /dev/null; then
        sudo firewall-cmd --permanent --add-port=41641/udp
        sudo firewall-cmd --permanent --add-port=3478/udp
        sudo firewall-cmd --permanent --add-port=50000-51000/udp
        sudo firewall-cmd --reload
    else
        echo -e "${YELLOW}No firewall detected. Ensuring ports are open with iptables...${STD}"
        sudo iptables -A INPUT -p udp --dport 41641 -j ACCEPT
        sudo iptables -A INPUT -p udp --dport 3478 -j ACCEPT
        sudo iptables -A INPUT -p udp --dport 50000:51000 -j ACCEPT
    fi
    
    # Display menu for Tailscale configuration
    echo -e "${GREEN}Tailscale port configuration complete.${STD}"
    echo -e "${YELLOW}Choose Tailscale authentication option:${STD}"
    echo "1. Interactive authentication (requires browser access)"
    echo "2. Auth key authentication (better for servers)"
    echo "3. Skip authentication (if already authenticated)"
    
    read -p "Enter choice [1-3]: " auth_choice
    case $auth_choice in
        1)
            echo -e "${YELLOW}Starting Tailscale with exit node functionality...${STD}"
            sudo tailscale down
            sudo tailscale up --advertise-exit-node --accept-routes
            ;;
        2)
            read -p "Enter your Tailscale auth key: " auth_key
            echo -e "${YELLOW}Starting Tailscale with exit node functionality using auth key...${STD}"
            sudo tailscale down
            sudo tailscale up --advertise-exit-node --accept-routes --auth-key "$auth_key"
            ;;
        3)
            echo -e "${YELLOW}Reconfiguring Tailscale as exit node...${STD}"
            sudo tailscale up --advertise-exit-node --accept-routes
            ;;
        *)
            echo -e "${RED}Invalid option.${STD}"
            ;;
    esac
    
    # Check Tailscale status
    echo -e "${YELLOW}Checking Tailscale status...${STD}"
    sudo tailscale status
    
    echo -e "${GREEN}Tailscale exit node setup complete.${STD}"
    echo -e "${YELLOW}Important: In the Tailscale admin console, enable exit nodes for your network${STD}"
    echo -e "${YELLOW}On client devices, select this node as exit node to use it${STD}"
}

# Function to display the options
display_options() {
    echo -e "${GREEN}Web Hosting Panel Installation Options${STD}"
    echo "---------------------------------------"
    echo "1. Install CloudPanel"
    echo "2. Install RatPanel"
    echo "3. Install CASA Panel"
    echo "4. Install Froxlor"
    echo "5. Install aaPanel"
    echo "6. Install Webmin"
    echo "7. Install Virtualmin"
    echo "8. Reset iptables"
    echo "9. Install Tailscale"
    echo "10. Install Web Utilities (nginx, curl, wget, git)"
    echo "11. Setup Tailscale Exit Node with Port Configuration"
    echo "12. Exit"
    echo
}

# Main script
clear
display_ascii_art
setup_firewall
while true; do
    display_options
    read -p "Enter your choice [1-12]: " choice

    case $choice in
        1) install_cloudpanel ;;
        2) install_ratpanel ;;
        3) install_casa ;;
        4) install_froxlor ;;
        5) install_aapanel ;;
        6) install_webmin ;;
        7) install_virtualmin ;;
        8) reset_iptables ;;
        9) install_tailscale ;;
        10) install_web_utilities ;;
        11) setup_tailscale_exit_node ;;
        12) echo -e "${GREEN}Exiting...${STD}"; exit 0 ;;
        *) echo -e "${RED}Invalid option. Please select a valid option.${STD}" ;;
    esac
done
