#!/bin/bash
# A menu-driven shell script sample template 

# ----------------------------------
# Step #1: Define variables
# ----------------------------------
EDITOR=vim
PASSWD=/etc/passwd
RED='\033[0;41;30m'
STD='\033[0;0;39m'

# ----------------------------------
# Step #2: User defined function
# ----------------------------------
pause() {
  read -p "Press [Enter] key to continue..." fackEnterKey
}

one() {
    echo "one() called"
    pause
}

two() {
    echo "two() called"
    pause
}

# function to display menus
show_menus() {
    clear
    echo "~~~~~~~~~~~~~~~~~~~~~"
    echo " M A I N - M E N U"
    echo "~~~~~~~~~~~~~~~~~~~~~"
    echo "1. Set Terminal"
    echo "2. Reset Terminal"
    echo "3. Exit"
}

# read input from the keyboard and take an action
# invoke the one() when the user selects 1 from the menu option.
# invoke the two() when the user selects 2 from the menu option.
# Exit when the user selects 3 from the menu option.
read_options() {
    local choice
    read -p "Enter choice [ 1 - 3] " choice
    case $choice in
        1) one ;;
        2) two ;;
        3) exit 0 ;;
        *) echo -e "${RED}Error...${STD}" && sleep 2
    esac
}

# ----------------------------------------------
# Step #3: Trap CTRL+C, CTRL+Z and quit signals
# ----------------------------------------------
trap '' SIGINT SIGQUIT SIGTSTP

# -----------------------------------
# Step #4: Main logic - infinite loop
# ------------------------------------
while true
do
    show_menus
    read_options
done
