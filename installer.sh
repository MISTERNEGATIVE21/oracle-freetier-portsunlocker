#!/usr/bin/env bash

# ASCII Art Function
display_ascii_art() {
    echo " ____                       _     _     _____          __   __           ____      "
    echo "|  _ \                     | |   | |   |_   _|         \ \ / /          |  _ \     "
    echo "| |_) |_ __ ___  _   _  ___| |__ | |_    | |    ___     \ V /___  _   _ | |_) |_   _"
    echo "|  _ <| '__/ _ \| | | |/ __| '_ \| __|   | |   / _ \     \ // _ \| | | ||  _ <| | | |"
    echo "| |_) | | | (_) | |_| | (__| | | | |_    | |  | (_) |    | | (_) | |_| || |_) | |_| |"
    echo "|____/|_|  \___/ \__,_|\___|_| |_|\__|   |_|   \___/     \_/\___/ \__,_||____/ \__, |"
    echo "                                                                                __/ |"
    echo "                                                                               |___/ "
    echo "              __  __ _____  _____ _______ ______ _____   _   _ ______ _____       _______ _____      _______ "
    echo "             |  \/  |_   _|/ ____|__   __|  ____|  __ \ | \ | |  ____|  __ \   /\|__   __|_   _\ \   / / ____|"
    echo "             | \  / | | | | (___    | |  | |__  | |__) ||  \| | |__  | |  | | /  \  | |    | |  \ \_/ / |  __   "
    echo "             | |\/| | | |  \___ \   | |  |  __| |  _  / | . \` |  __| | |  | |/ /\ \ | |    | |   \   /| | |_ |"
    echo "             | |  | |_| |_ ____) |  | |  | |____| | \ \ | |\  | |____| |__| / ____ \| |   _| |_   | | | |__| |"
    echo "             |_|  |_|_____|_____/   |_|  |______|_|  \_\|_| \_|______|_____/_/    \_\_|  |_____|  |_|  \_____|"
    echo
    echo
}

# Function to display the options
display_options() {
    echo "Web Hosting Panel Installation Options"
    echo "---------------------------------------"
    echo "1. Install CloudPanel"
    echo "2. Install CyberPanel"
    echo "3. Install CASA Panel"
    echo "4. Install Froxlor"
    echo "5. Install aaPanel"
    echo "6. Install Webmin"
    echo "7. Install Virtualmin"
    echo "8. Check System Requirements"
    echo "9. View Panel Documentation"
    echo "10. Exit"
    echo
}

# Function to install CloudPanel
install_cloudpanel() {
    echo "Installing CloudPanel..."
    curl -sSL https://installer.cloudpanel.io/ce/v2/install.sh | sudo bash
}

# Function to install CyberPanel
install_cyberpanel() {
    echo "Installing CyberPanel..."
    sh <(curl -s https://cyberpanel.net/install.sh || wget -q -O - https://cyberpanel.net/install.sh)
}

# Function to install CASA Panel
install_casa() {
    echo "Installing CASA Panel..."
    echo "Please visit https://github.com/casaos/casaos for installation instructions."
}

# Function to install Froxlor
install_froxlor() {
    echo "Installing Froxlor..."
    echo "Please visit https://froxlor.org/install for installation instructions."
}

# Function to install aaPanel
install_aapanel() {
    echo "Installing aaPanel..."
    wget -O install.sh http://www.aapanel.com/script/install-ubuntu_6.0_en.sh && sudo bash install.sh
}

# Function to install Webmin
install_webmin() {
    echo "Installing Webmin..."
    sudo apt update
    sudo apt install -y wget apt-transport-https
    wget -q http://www.webmin.com/jcameron-key.asc -O- | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] http://download.webmin.com/download/repository sarge contrib"
    sudo apt update
    sudo apt install -y webmin
}

# Function to install Virtualmin
install_virtualmin() {
    echo "Installing Virtualmin..."
    wget -O virtualmin-install.sh https://raw.githubusercontent.com/virtualmin/virtualmin-install/master/virtualmin-install.sh
    sudo sh virtualmin-install.sh
}

# Function to check system requirements
check_requirements() {
    echo "Checking system requirements..."
    echo "Note: Requirements may vary depending on the panel you choose."
    echo "General minimum requirements:"
    echo "- 1 CPU Core"
    echo "- 1 GB RAM (2 GB or more recommended)"
    echo "- 10 GB Disk Space"
    echo "- 64-bit (x86_64) CPU"
    echo "- Ubuntu 20.04 LTS or later (for most panels)"
}

# Function to view documentation
view_documentation() {
    echo "Select a panel to view its documentation:"
    echo "1. CloudPanel"
    echo "2. CyberPanel"
    echo "3. CASA Panel"
    echo "4. Froxlor"
    echo "5. aaPanel"
    echo "6. Webmin"
    echo "7. Virtualmin"
    read -p "Enter your choice [1-7]: " doc_choice

    case $doc_choice in
        1) xdg-open "https://www.cloudpanel.io/docs/v2/" ;;
        2) xdg-open "https://docs.cyberpanel.net/" ;;
        3) xdg-open "https://github.com/casaos/casaos" ;;
        4) xdg-open "https://docs.froxlor.org/" ;;
        5) xdg-open "https://doc.aapanel.com/" ;;
        6) xdg-open "https://doxfer.webmin.com/Webmin/Main_Page" ;;
        7) xdg-open "https://www.virtualmin.com/documentation/" ;;
        *) echo "Invalid choice." ;;
    esac
}

# Main script
clear
display_ascii_art
display_options
read -p "Enter your choice [1-10]: " choice

case $choice in
    1) install_cloudpanel ;;
    2) install_cyberpanel ;;
    3) install_casa ;;
    4) install_froxlor ;;
    5) install_aapanel ;;
    6) install_webmin ;;
    7) install_virtualmin ;;
    8) check_requirements ;;
    9) view_documentation ;;
    10) echo "Exiting..."; exit 0 ;;
    *) echo "Invalid option. Please run the script again and select a valid option." ;;
esac
