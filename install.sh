#!/bin/bash
echo "Installing the bare essentials..."
sudo apt-get install -q=2 vim cmake mplayer
sudo apt-get install -q=2 nautilus-dropbox
dropbox start

mkdir -p ~/git/
cd ~/git
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
################################################################
cp -Rp .* ~
cd ~
################################################################
echo "Installing XMONAD..."
sudo cp ~/.xmonad/gnome-xmonad.desktop /usr/share/xsessions/gnome-xmonad.desktop
sudo cp ~/.xmonad/xmonad.session /usr/share/gnome-session/sessions/xmonad.session
echo "Installing BASHRC script in root directory..."
sudo cp -p ~/.bashrc /root
sudo mkdir /root/.bash
sudo cp -p ~/.bash/apt_tab_completion /root/.bash
mkdir -p .vim/bundle/
################################################################
sudo apt-get install vlc htop nautilus-open-terminal curl libmp3lame0 \
cmake-curses-gui silversearcher-ag youtube-dl xmonad libghc-xmonad-dev \
libghc-xmonad-contrib-dev xmobar xcompmgr nitrogen stalonetray moreutils \
consolekit ssh-askpass-gnome thunar terminator remmina gnome-panel \
xclip \
libc-ares2 libcrypto++-dev libcrypto++9 \
gimp inkscape libssl-dev openssl libx11-dev \
etoolbox python-pip gfortran \
exuberant-ctags \
python-matplotlib python-pip 
################################################################
echo "Installing Python packages"
sudo pip install networkx
sudo pip install cvxpy
echo 'import numpy as np' >> $(ipython locate profile default)/startup/00_imports.py
echo 'import matplotlib.pyplot as plt' >> $(ipython locate profile default)/startup/00_imports.py


echo "disabling keypad"
echo "run xinput list; xinput set-prop 12 "Device Enabled" 0"

echo "Installing LATEX essentials"
sudo apt-get install texlive-full 

echo "Displaying date in time indicator"
gsettings set com.canonical.indicator.datetime show-clock true
gsettings set com.canonical.indicator.datetime show-day true
gsettings set com.canonical.indicator.datetime show-date true
cd ~/Downloads
wget https://mega.nz/linux/MEGAsync/xUbuntu_14.04/amd64/megasync-xUbuntu_14.04_amd64.deb
sudo dpkg -i megasync-xUbuntu_14.04_amd64.deb
megasync

echo "FIREFOX: install vimperator | noscript | adblockplus"


echo 'Installing programming environment'
echo "Logout and LOGIN to Gnome with XMONAD"
#opengl
#glut
#boost
