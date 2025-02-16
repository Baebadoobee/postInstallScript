#!/usr/bin/bash

# Connectiong to the internet
# nmcli device wifi '<ID>' password '<PASSWORD>'

# Basic packages
pacman -S --disable-download-timeout --noconfirm --quiet alacritty alsa-utils device-mapper git grim lapack libnotify links linux-headers mesa neofetch ninja pipewire pulseaudio pulseaudio-alsa sddm wget xorg-server xorg-xinit xorg-apps

# Yay installation
git clone https://aur.archlinux.org/yay-bin.git $HOME/yay-bin
cd $HOME/yay-bin
makepkg -si
cd $HOME/.pIS

# Installation script setup
yay -S powershell-bin
pwsh --noprofile -NoLogo -NoExit -c "Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser; ./$HOME/.pIS/installationScript.ps1"