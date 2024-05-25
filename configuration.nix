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
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nix.settings.max-jobs = 32;

  chaotic.mesa-git.enable = true;

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
    signal-desktop
    docker-compose
    podman-tui
    dive
    tealdeer
    lxqt.lxqt-policykit
    dunst
    wofi
    bat
    fd
    ripgrep
    wlr-randr
    jetbrains.webstorm
    wl-clipboard
    cifs-utils
    nodejs_20
    solaar
    dosfstools
    e2fsprogs
  ];

  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman
    ];
  };
  # without this you can't save preferences in thunar when not running xfce
  programs.xfconf.enable = true;
  services.gvfs.enable = true;
  services.tumbler.enable = true;

  fonts.packages = with pkgs; [
    inter
    jetbrains-mono
    nerdfonts
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
  ];

  fileSystems."/mnt/sharez" = {
    device = "//192.168.0.136/nadanke";
    fsType = "cifs";
    options = let
      # this line prevents hanging on network split
      automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s,user,users";
    in ["${automount_opts},credentials=/etc/nixos/smb-secrets,uid=1000,gid=1000"];
  };
}

