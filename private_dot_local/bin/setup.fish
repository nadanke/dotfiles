#!/usr/bin/env fish
sudo pacman -S neovim bluez flatpak

systemctl enable --now bluetooth

# have flatpaks default to dark themes
gsettings set org.gnome.desktop.interface color-scheme prefer-dark
