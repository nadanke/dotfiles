{ config, pkgs, ... }:

{
  # Example home-manager configuration
  home.username = "testo";
  home.homeDirectory = "/home/testo";

  programs.home-manager.enable = true;

  # Add your home-manager configurations here
  home.packages = with pkgs; [
    neovim
    git
  ];

  # more config options...
}
