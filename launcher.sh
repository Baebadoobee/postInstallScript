#!/usr/bin/bash

# Connecting to the internet
# Unccoment the following line if you are using wifi
# nmcli device wifi '<ID>' password '<PASSWORD>'

# Needed packages
sudo pacman -S --disable-download-timeout --noconfirm --quiet --needed base linux linux-firmware base-devel sudo git

# Yay installation
git clone https://aur.archlinux.org/yay-bin.git $HOME/yay-bin
makepkg -siD $HOME/yay-bin

# Installation script setup
yay -S powershell-bin
pwsh --noprofile -NoLogo -NoExit -c "Start-Process $HOME/.pIS/installationScript.ps1"