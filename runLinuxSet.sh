#!/bin/bash

#works if called grep is installed
#Recommended to run on bash on an Ubuntu-based distro

TARGET_DIR="MySetup/"
LOG_FILE="log.txt"
PACKAGES="vim vim-gtk3 emacs tmux youtube-dl ffmpeg python3 python python-pip gcc g++ valgrind clisp ghc gdb 
synaptic gedit default-jdk mpv xdotool redshift-gtk pandoc dict"


PACKAGE_TEST="xdotool"
RED='\033[31m'
GREEN='\033[32m'
NC='\033[0m' # No Color

homeD() {
    cd "./$TARGET_DIR"
}


#check if it is the right distro (later)
# uname -a | grep "ubuntu"


#1 create a new directory and stay there
[ ! -d "$TARGET_DIR" ] && mkdir "$TARGET_DIR"; 
homeD;
touch ./$LOG_FILE
> "./$LOG_FILE"
echo "log file and working directory created" >> ./$LOG_FILE

#2 download all the packages specified
{
    sudo apt-get update
    sudo apt-get upgrade

    for i in $PACKAGES
    do
    echo "${GREEN}INSTALLING $i...${NC}"
    sudo apt-get -y install $i

        if ( dpkg -s $i | grep "ok installed" )
        then 
           echo -e "${GREEN}PACKAGE $i INSTALLED${NC}" 
        else
           echo -e "${RED}PACKAGE $i NOT FOUND${NC}" 
        fi 

    done #finished installing packages

    #Get my vimrc file
    wget -O ~/.vimrc https://raw.githubusercontent.com/Garenium/my-vimrc/main/.vimrc 

    #GET my .tmux.config file
    wget -O ~/.tmux.conf https://raw.githubusercontent.com/Garenium/my-scripts/main/MyTmuxConfig/tmux.conf

    #Switch caps and escape keys by appending to .profile (requires reboot)
    grep -qxF "setxkbmap -option caps:swapescape" ~/.profile || echo "$SWAP_ENABLE" >> ~/.profile 

} | tee ./$LOG_FILE


echo "Installation/upgrade processes written to log"

#SHOW WHAT'S PRINTED INSIDE THE LOG FILE (OPTIONAL)
# echo -e "\nWHAT'S INSIDE THE LOG FILE: "
# cat "./$LOG_FILE"

echo "restarting the laptop in 10 seconds..."
sleep 10 
shutdown -r now
