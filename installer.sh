#!/usr/bin/env bash

# Function to display ASCII art
display_ascii_art() {
    cat << "EOF"
 ____                       _     _     _____          __   __           ____      
|  _ \                     | |   | |   |_   _|         \ \ / /          |  _ \     
| |_) |_ __ ___  _   _  ___| |__ | |_    | |    ___     \ V /___  _   _ | |_) |_   _
|  _ <| '__/ _ \| | | |/ __| '_ \| __|   | |   / _ \     \ // _ \| | | ||  _ <| | | |
| |_) | | | (_) | |_| | (__| | | | |_    | |  | (_) |    | | (_) | |_| || |_) | |_| |
|____/|_|  \___/ \__,_|\___|_| |_|\__|   |_|   \___/     \_/\___/ \__,_||____/ \__, |
                                                                                __/ |
                                                                               |___/ 
              __  __ _____  _____ _______ ______ _____   _   _ ______ _____       _______ _____      _______ 
             |  \/  |_   _|/ ____|__   __|  ____|  __ \ | \ | |  ____|  __ \   /\|__   __|_   _\ \   / / ____|
             | \  / | | | | (___    | |  | |__  | |__) ||  \| | |__  | |  | | /  \  | |    | |  \ \_/ / |  __  
             | |\/| | | |  \___ \   | |  |  __| |  _  / | . ` |  __| | |  | |/ /\ \ | |    | |   \   /| | |_ | 
             | |  | |_| |_ ____) |  | |  | |____| | \ \ | |\  | |____| |__| / ____ \| |   _| |_   | | | |__| | 
             |_|  |_|_____|_____/   |_|  |______|_|  \_\|_| \_|______|_____/_/    \_\_|  |_____|  |_|  \_____| 
EOF
    echo
    echo
}

# Function to display the menu options
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
    echo "10. Set Terminal"
    echo "11. Reset Terminal"
    echo "12. Exit"
    echo
}

# Function to install CloudPanel
install_cloudpanel() {
    echo "Installing CloudPanel..."
    if curl -sSL https://installer.cloudpanel.io/ce/v2/install.sh | sudo bash; then
        echo "CloudPanel installed successfully."
    else
        echo "Failed to install CloudPanel."
    fi
    pause
}

# Function to install CyberPanel
install_cyberpanel() {
    echo "Installing CyberPanel..."
    if sh <(curl -s https://cyberpanel.net/install.sh || wget -q -O - https://cyberpanel.net/install.sh); then
        echo "CyberPanel installed successfully."
    else
        echo "Failed to install CyberPanel."
    fi
    pause
}

# Function to install CASA Panel
install_casa() {
    echo "Installing CASA Panel..."
    echo "Please visit https://github.com/casaos/casaos for installation instructions."
    pause
}

# Function to install Froxlor
install_froxlor() {
    echo "Installing Froxlor..."
    echo "Please visit https://froxlor.org/install for installation instructions."
    pause
}

# Function to install aaPanel
install_aapanel() {
    echo "Installing aaPanel..."
    if wget -O install.sh http://www.aapanel.com/script/install-ubuntu_6.0_en.sh && sudo bash install.sh; then
        echo "aaPanel installed successfully."
    else
        echo "Failed to install aaPanel."
    fi
    pause
}

# Function to install Webmin
install_webmin() {
    echo "Installing Webmin..."
    sudo apt update
    sudo apt install -y wget apt-transport-https
    wget -q http://www.webmin.com/jcameron-key.asc -O- | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] http://download.webmin.com/download/repository sarge contrib"
    sudo apt update
    if sudo apt install -y webmin; then
        echo "Webmin installed successfully."
    else
        echo "Failed to install Webmin."
    fi
    pause
}

# Function to install Virtualmin
install_virtualmin() {
    echo "Installing Virtualmin..."
    if wget -O virtualmin-install.sh https://raw.githubusercontent.com/virtualmin/virtualmin-install/master/virtualmin-install.sh && sudo sh virtualmin-install.sh; then
        echo "Virtualmin installed successfully."
    else
        echo "Failed to install Virtualmin."
    fi
    pause
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
    pause
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
    pause
}

# Function to pause and wait for user input
pause(){
  read -p "Press [Enter] key to continue..." fackEnterKey
}

# Function to set terminal
set_terminal(){
    echo "Setting terminal..."
    # Add terminal setting commands here
    pause
}

# Function to reset terminal
reset_terminal(){
    echo "Resetting terminal..."
    # Add terminal reset commands here
    pause
}

# Function to display menus
show_menus() {
    clear
    display_ascii_art
    display_options
}

# Function to read input from the keyboard and take action
read_options(){
    local choice
    read -p "Enter choice [1-12]: " choice
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
        10) set_terminal ;;
        11) reset_terminal ;;
        12) echo "Exiting..."; exit 0 ;;
        *) echo "Error... Invalid option." && sleep 2
    esac
}

# Trap CTRL+C, CTRL+Z and quit signals
trap '' SIGINT SIGQUIT SIGTSTP

# Main logic - infinite loop
while true
do
    show_menus
    read_options
done
