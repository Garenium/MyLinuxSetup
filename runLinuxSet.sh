#!/bin/bash

#works if called grep is installed

TARGET_DIR="MySetup/"
LOG_FILE="log.txt"
PACKAGES="vim 
vim-gtk3 emacs tmux youtube-dl ffmpeg python3 python python-pip gcc g++ clisp ghc gdb synaptic gedit default-jdk xdotool"


PACKAGE_TEST="vim-gtk3"
RED='\033[31m'
GREEN='\033[32m'
NC='\033[0m' # No Color

homeD() {
    cd "./$TARGET_DIR"
}


# uname -a | grep "ubuntu"


#1 create a new directory and stay there
[ ! -d "$TARGET_DIR" ] && mkdir "$TARGET_DIR"; 
homeD;
touch ./$LOG_FILE
> "./$LOG_FILE"
echo "log file and working directory created" >> ./$LOG_FILE

#2 download all the packages specified
{
    # sudo apt-get update
    # sudo apt-get upgrade

    for i in $PACKAGE_TEST
    do
    sudo apt-get install $i

    if ( dpkg -s $i | grep "ok installed" )
    then 
       echo -e "${GREEN}PACKAGE $i INSTALLED${NC}" 
    else
       echo -e "${RED}PACKAGE $i NOT INSTALLED${NC}" 
    fi 

    done


    # wget -O ~/.vimrc https://raw.githubusercontent.com/Garenium/my-vimrc/main/.vimrc 

    SWAP_ENABLE="setxkbmap -option caps:swapescape"
    grep -qxF "$SWAP_ENABLE" ~/.profile || echo "$SWAP_ENABLE" >> ~/.profile 
 
} | tee ./$LOG_FILE


echo "Installation/upgrade processes written to log"

#DEBUG
# echo -e "\nWHAT'S INSIDE THE LOG FILE: "
# cat "./$LOG_FILE"

# echo "restarting the laptop in 5 seconds..."
# sleep 5
# shutdown -r now

