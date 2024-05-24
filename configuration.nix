# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./modules/base.nix
      ./modules/amdgpu.nix
      ./modules/plasma.nix
      ./modules/user.nix
      ./modules/vscode.nix
      ./modules/steam.nix
      ./modules/containers.nix
      <home-manager/nixos>
    ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    helix
    kdePackages.plasma-pa
    gamescope
    gamescope-wsi
    procs
    git
    lsd
    slack
    element-desktop
    spotify
    mpv
    goverlay
    mangohud
    lact
    signal-desktop
    docker-compose
    podman-tui
    dive
    tealdeer
    xfce.thunar
    lxqt.lxqt-policykit
    dunst
    waybar
    wofi
    bat
    fd
    ripgrep
  ];

  fonts.packages = with pkgs; [
    inter
    jetbrains-mono
    nerdfonts
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
  ];
}

