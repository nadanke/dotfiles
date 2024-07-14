{ config, pkgs, inputs, ... }:

{
  programs.gamemode = {
    enable = true;
    enableRenice = true;
    settings = {
      general = {
        renice = 10;
      };

      custom = {
        start = "${pkgs.libnotify}/bin/notify-send 'GameMode started'";
        end = "${pkgs.libnotify}/bin/notify-send 'GameMode ended'";
      };
    };
  };

  users.users.nadanke = {
      isNormalUser = true;
      description = "big shmingus";
      extraGroups = [ "networkmanager" "wheel" "docker" ];
      packages = with pkgs; [
        procs
        gzdoom
        wev
        git
        iperf3
        lsd
        tealdeer
        bat
        fd
        ripgrep
        unzip
        gcc
        clang
        libtool
        gnumake
        ncurses
        gdu
        killall
        zellij
        libnotify
        cmake
        mdl
        discount
        shellcheck
        pavucontrol
        mumble
        bottom
        slurp
        grim
        swappy
        nmap
        gamescope
        gamescope-wsi
        kdePackages.plasma-pa
        element-desktop
        spotify
        losslesscut-bin
        mpv
        goverlay
        mangohud
        signal-desktop
        slack
        lxqt.lxqt-policykit
        wlr-randr
        jetbrains.webstorm
        wl-clipboard
        cliphist
        nodejs_20
        playerctl
        openmw
        godot_4
        gpu-screen-recorder
        bottles
        wezterm
        ethtool
        networkmanagerapplet
        neovim
        distrobox
        stremio
        krita
        pinta
        gimp
        imv
        blueman
        dbgate
        postgresql
        yt-dlp
      ];
  };

    # Enable automatic login for the user.
    services.getty.autologinUser = "nadanke";

    home-manager.users.nadanke = { pkgs, ... }: {
      home.stateVersion = "23.11";

      programs = {
        obs-studio = {
          enable = true;
          plugins = [
            pkgs.obs-studio-plugins.wlrobs
          ];
        };

        fish = {
          enable = true;
          functions = {
            cat = "bat $argv";
            codium-ext-up = "~/nixpkgs/pkgs/applications/editors/vscode/extensions/update_installed_exts.sh";
            code = "codium $argv";
            msync = "rsync -avh --progress $argv";
            fuckplasma = "procs --no-header --only PID kwin_wayland_wrapper | xargs kill -9";
            mkill = "procs --no-header --only PID $argv | xargs kill -9";
            dc = "docker compose $argv";
          };
        };

        git = {
          enable = true;
          userName = "Mario Bruestle";
          userEmail = "mario.bruestle@pm.me";
          extraConfig = {
            color = {
              ui = true;
              pager = true;
            };
          };
        };

        hyprlock.enable = true;

        rofi = {
          enable = true;
          package = pkgs.rofi-wayland;
          theme = "android_notification.rasi";
        };

        lsd = {
          enable = true;
          enableAliases = true;
        };

        zoxide = {
          enable = true;
          enableFishIntegration = true;
        };

        waybar = {
          enable = true;
          settings = {
            mainBar = {
              layer = "top";
              position = "bottom";
              modules-left = [ "hyprland/workspaces" ];
              modules-center = [ "hyprland/window" ];
              modules-right = [ "load" "wireplumber" "clock" "tray" ];
              output = [
                "DP-1"
                "HDMI-A-2"
              ];
              spacing = 8;
              height = 26;
              tray = {
                spacing = 4;
              };
              wireplumber = {
                on-click = "pavucontrol";
              };
            };
          };
        };

        alacritty = {
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

        chromium = {
          enable = true;
          package = pkgs.brave;
          extensions = [
            { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; }
            { id = "ghmbeldphafepmbegfdlkpapadhbakde"; }
            { id = "jinjaccalgkegednnccohejagnlnfdag"; }
            { id = "mnjggcdmjocbbbhaepdhchncahnbgone"; }
          ];
        };
      };

      services.swaync = {
        enable = true;
        settings = {
          positionX = "right";
          positionY = "right";
          control-center-positionX = "none";
          control-center-positionY = "none";
          control-center-margin-top = 8;
          control-center-margin-bottom = 8;
          control-center-margin-right = 8;
          control-center-margin-left = 8;
          control-center-width = 500;
          control-center-height = 600;
          fit-to-screen = true;

          layer-shell = true;
          layer = "overlay";
          control-center-layer = "overlay";
          cssPriority = "user";
          notification-icon-size = 64;
          notification-body-image-height = 100;
          notification-body-image-width = 200;
          notification-inline-replies = true;
          timeout = 10;
          timeout-low = 5;
          timeout-critical = 0;
          notification-window-width = 500;
          keyboard-shortcuts = true;
          image-visibility = "always";
          transition-time = 200;
          hide-on-clear = true;
          hide-on-action = true;
          script-fail-notify = true;
        };

        style = ''
          .control-center {
            background: rgba(46, 46, 46, 1);
          }
        '';
      };


    home.sessionPath = [
      "$HOME/.local/bin"
    ];

    home.file = {
      wallpaper = {
        enable = true;
        source = ./wp.jpg;
        target = ".wallpaper/wp.jpg";
      };

      toggleRecording = {
        enable = true;
        target = ".local/bin/toggle-recording.fish";
        executable = true;
        text = ''
          #!/usr/bin/env fish
          set is_running (pgrep -f gpu-screen-recorder)

          if test -z "$is_running"
            # No running instance, start it
            sh -c 'gpu-screen-recorder -w DP-1 -f 60 -a "$(pactl get-default-sink).monitor|$(pactl get-default-source)" -r 120 -k h265 -o ~/Videos/ -c mp4' &
            notify-send "GPU Screen Recorder" "Recording started."
          else
            # Running instance, stop it
            pkill -f gpu-screen-recorder
            notify-send "GPU Screen Recorder" "Recording stopped."
          end
        '';
      };

      saveRecording = {
        enable = true;
        target = ".local/bin/save-recording.fish";
        executable = true;
        text = ''
          #!/usr/bin/env fish
          set is_running (pgrep -f gpu-screen-recorder)

          if test -z "$is_running"
            notify-send "GPU Screen Recorder" "No recording running."
            exit 1
          end

          killall -SIGUSR1 gpu-screen-recorder
          notify-send "GPU Screen Recorder" "Recording saved."
        '';
      };

      waybarStyles = {
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

          #tags button.occupied {
            background: rgba(123, 93, 82, 0.5);
          }

          #tags button.focused {
            background: rgba(92, 121, 211, 0.5);
          }
        '';
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

    services.hyprpaper = {
      enable = true;
      settings = {
        splash = false;
        preload = [ "/home/nadanke/.wallpaper/wp.jpg" ];
        wallpaper = [
          "DP-1,/home/nadanke/.wallpaper/wp.jpg"
          "HDMI-A-2,/home/nadanke/.wallpaper/wp.jpg"
          "HDMI-A-1,/home/nadanke/.wallpaper/wp.jpg"
        ];
      };
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
        "waybar"
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
        "steam"
        "solaar"
        "spotify"
      ];

      dwindle = {
        preserve_split = true;
        no_gaps_when_only = true;
      };

      xwayland.force_zero_scaling = true;
      
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
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPrev, exec, playerctl previous"
      ];

      bind =
        [
          "$mod, x, exec, brave"
          "$mod, RETURN, exec, alacritty"
          "$mod, q, killactive,"
          "$mod, m, exit,"
          "$mod, c, exec, thunar"
          "$mod, j, togglesplit,"
          "$mod, s, exec, rofi -show drun -modes drun,run -show-icons"
          "$mod, z, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"
          ''$mod SHIFT, s, exec, grim -g "$(slurp)" - | swappy -f -''
          "$mod SHIFT, F11, exec, ~/.local/bin/toggle-recording.fish"
          "$mod SHIFT, F12, exec, ~/.local/bin/save-recording.fish"

          ", Print, exec, playerctl -p spotify volume 0.05-"
          ", Scroll_Lock, exec, playerctl -p spotify volume 0.05+"

          "$mod, t, fullscreen"

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
          ", XF86Launch6, exec, swaync-client -t -sw"
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
        force_no_accel = true;
      };
      animations = {
        enabled = false;
      };

     cursor = {
       inactive_timeout = 5;
     };

      general = {
        gaps_in = 0;
        gaps_out = 0;

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
