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
mkdir -p .vim/bundle/
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
echo "Installing VLC|DROPBOX..."
sudo apt-get install vlc 
echo "Installing MISC programs..."
sudo apt-get install htop nautilus-open-terminal curl libmp3lame0 cmake-curses-gui silversearcher-ag youtube-dl 
echo "disabling keypad"
echo "run xinput list; xinput set-prop 12 "Device Enabled" 0"

echo "Installing LATEX essentials"
sudo apt-get install texlive-full etoolbox
echo "Displaying date in time indicator"
gsettings set com.canonical.indicator.datetime show-clock true
gsettings set com.canonical.indicator.datetime show-day true
gsettings set com.canonical.indicator.datetime show-date true

