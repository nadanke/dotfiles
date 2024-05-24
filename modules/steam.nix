{ config, pkgs, ... }:

{
    programs.steam.enable = true;

    # this is currently needed for gamescope to work with steam and shouldn't be needed once the mr is merged
    nixpkgs.config.packageOverrides = pkgs: {
        steam = pkgs.steam.override {
            extraPkgs = pkgs: with pkgs; [
                xorg.libXcursor
                xorg.libXi
                xorg.libXinerama
                xorg.libXScrnSaver
                libpng
                libpulseaudio
                libvorbis
                stdenv.cc.cc.lib
                libkrb5
                keyutils
            ];
        };
    };
}
