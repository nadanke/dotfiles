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
      cat = "bat $argv";
    };

    programs.waybar = {
      enable = true;
      settings = {
        mainBar = {
          layer = "top";
          position = "bottom";
          modules-left = [ "hyprland/workspaces" ];
          modules-center = [ "hyprland/window" ];
          modules-right = [ "wireplumber" "clock" "tray" ];
          output = [
            "DP-1"
            "HDMI-A-2"
          ];
          spacing = 8;
          height = 26;
        };
      };
    };
    home.file.waybarStyles = {
      enable = true;
      target = ".config/waybar/style.css";
      text = ''
        * {
          font-family: Inter;
        }
      
        #workspaces button.active {
          background: rgba(123,39,211,0.4);
          border-radius: 0;
        }

        window#waybar {
          background: rgba(93, 123, 81, 0.4);
        }

        #clock, #tray {
          padding-right: 8px;
        }

        #workspaces,
        #workspaces * {
          padding: 0;
          margin: 0;
        }

        #workspaces button {
          padding-left: 5px;
          padding-right: 5px;
        }
      '';
    };
    

    programs.alacritty = {
      enable = true;
      settings = {
        shell = "fish";
        window = {
          padding = {
            x = 10;
            y = 10;
          };
        };
        font = {
          normal = {
            family = "JetBrains Mono";
            style = "Regular";
          };
        };
      };
    };

    home.pointerCursor = {
      gtk.enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Original-Classic";
      size = 16;
    };

    gtk = {
      enable = true;
      theme = {
        package = pkgs.gnome-themes-extra;
        name = "Adwaita-dark";
      };
      font = {
        name = "Inter";
        size = 11;
      };
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
    wayland.windowManager.hyprland.systemd.variables = [ "--all" ];
    wayland.windowManager.hyprland.settings = {
      "$mod" = "SUPER";
      monitor = [
        "DP-1,3840x2160@165,0x0,1.25,vrr,2"
        #"HDMI-A-1,3840x2160@120,-3840x0,1,vrr,2"
        "HDMI-A-1,disable"
        "HDMI-A-2,3840x2160@60,3072x288,1.5,vrr,0"
      ];
      exec-once = [
        "lxqt-policykit-agent"
        "dunst"
        "waybar"
      ];

      dwindle = {
        preserve_split = true;
      };
      
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
      bindel = [
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ -l 1"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- -l 1"
      ];
      bindl = [
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ];

      bind =
        [
          "$mod, x, exec, brave"
          "$mod, RETURN, exec, alacritty"
          "$mod, q, killactive,"
          "$mod, m, exit,"
          "$mod, c, exec, thunar"
          "$mod, j, togglesplit,"
          "$mod, s, exec, wofi --allow-images --show drun,run"

          "$mod, left, movefocus, l"
          "$mod, right, movefocus, r"
          "$mod, up, movefocus, u"
          "$mod, down, movefocus, d"

          "$mod, i, movefocus, r"
          "$mod, n, movefocus, l"
          "$mod, u, movefocus, u"
          "$mod, e, movefocus, d"

          
          "$mod SHIFT, left, movewindow, l"
          "$mod SHIFT, right, movewindow, r"
          "$mod SHIFT, up, movewindow, u"
          "$mod SHIFT, down, movewindow, d"

          "$mod SHIFT, i, movewindow, r"
          "$mod SHIFT, n, movewindow, l"
          "$mod SHIFT, u, movewindow, u"
          "$mod SHIFT, e, movewindow, d"

          "$mod, mouse_down, workspace, e+1"
          "$mod, mouse_up, workspace, e-1"

          "$mod, v, togglefloating,"
        ]
        ++ (
          builtins.concatLists (builtins.genList (
            x: let
              ws = let
                c = (x + 1) / 10;
              in
                builtins.toString (x + 1 - (c * 10));
            in [
              "$mod, ${ws}, workspace, ${toString (x + 1)}"
              "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
            ]
          )
          10)

      );
      input = {
        kb_layout = "us";
        kb_variant = "colemak";
        follow_mouse = 1;
        sensitivity = -0.6;
        force_no_accel = true;
      };
      animations = {
        enabled = false;
      };
      general = {
        gaps_in = 0;
        gaps_out = 0;

        allow_tearing = true;
        layout = "dwindle";

        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
      };
      decoration = {
        rounding = 0;
      };
    };
  };
}
