{ config, pkgs, ... }:

{
    users.users.nadanke = {
        isNormalUser = true;
        description = "big shmingus";
        extraGroups = [ "networkmanager" "wheel" "docker" ];
        packages = with pkgs; [];
    };

    # Enable automatic login for the user.
    services.getty.autologinUser = "nadanke";


    home-manager.users.nadanke = { pkgs, ... }: {
    home.packages = [];
    home.stateVersion = "23.11";
    programs.fish.enable = true;
    programs.fish.functions = {
      ls = "lsd $argv";
    };
    dconf = {
      enable = true;
      settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
    };
    programs.chromium = {
      enable = true;
      package = pkgs.brave;
      extensions = [
        { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; }
        { id = "ghmbeldphafepmbegfdlkpapadhbakde"; }
        { id = "jinjaccalgkegednnccohejagnlnfdag"; }
      ];
    };
    wayland.windowManager.hyprland.enable = true;
    wayland.windowManager.hyprland.settings = {
      "$mod" = "SUPER";
      bind =
        [
          "$mod, x, exec, brave"
          "$mod, enter, exec, alacritty"
        ]
        ++ (
          builtins.concatLists (builtins.genList (
            x: let
              ws = builtins.toString (x + 1);
            in [
              "$mod, ${ws}, workspace, ${toString (x + 1)}"
              "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
            ]) 10)
          );
        };
    };
}