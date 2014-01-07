#!/bin/bash
cp -R .* ~
cd ~
echo "Installing XMONAD..."
sudo cp ~/.xmonad/gnome-xmonad.desktop /usr/share/xsessions/gnome-xmonad.desktop
sudo cp ~/.xmonad/xmonad.session /usr/share/gnome-session/sessions/xmonad.session
echo "Installing BASHRC script in root directory..."
sudo cp ~/.bashrc /root
sudo mkdir /root/.bash
sudo cp ~/.bash/apt_tab_completion /root/.bash
echo "Installing VLC|DROPBOX..."
sudo apt-get install nautilus-dropbox vlc 
echo "Installing MISC programs..."
sudo apt-get install htop nautilus-open-terminal
echo "run xinput list; xinput set-prop 12 "Device Enabled" 0"
