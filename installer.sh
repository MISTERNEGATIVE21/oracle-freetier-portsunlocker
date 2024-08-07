#!/bin/bash

# Variables
RED='\033[0;41;30m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
STD='\033[0;0;39m'

# Functions
pause() {
  read -p "Press [Enter] key to continue..." fackEnterKey
}

install_apache() {
    echo -e "${YELLOW}Installing Apache...${STD}"
    # Add actual Apache installation commands here
    echo -e "${GREEN}Apache installed successfully.${STD}"
    pause
}

install_nginx() {
    echo -e "${YELLOW}Installing Nginx...${STD}"
    # Add actual Nginx installation commands here
    echo -e "${GREEN}Nginx installed successfully.${STD}"
    pause
}

show_menu() {
    clear
    echo "~~~~~~~~~~~~~~~~~~~~~~~~~~"
    echo " Web Panel Installer Menu "
    echo "~~~~~~~~~~~~~~~~~~~~~~~~~~"
    echo "1. Install Apache"
    echo "2. Install Nginx"
    echo "3. Exit"
}

read_option() {
    local choice
    read -p "Enter choice [ 1 - 3 ] " choice
    case $choice in
        1) install_apache ;;
        2) install_nginx ;;
        3) exit 0;;
        *) echo -e "${RED}Error: Invalid option...${STD}" && sleep 2
    esac
}

# Trap CTRL+C, CTRL+Z and quit signals
trap '' SIGINT SIGQUIT SIGTSTP

# Main loop
while true
do
    show_menu
    read_option
done
