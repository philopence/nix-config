{ inputs, outputs, lib, config, pkgs, ... }: {

  imports = [
    ./kitty.nix
    ./rofi.nix
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
      # ISSUE  https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = (_: true);
    };
  };

  # fonts.fontconfig.enable = true;

  home = {
    username = "philopence";
    homeDirectory = "/home/philopence";
  };

  home.sessionVariables = {
    # EDITOR = "nvim";
    GLFW_IM_MODULE = "ibus";
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_BIN_HOME = "$HOME/.local/bin";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_STATE_HOME = "$HOME/.local/state";
  };
  home.sessionPath = [ "$XDG_BIN_HOME" "$XDG_DATA_HOME/npm/bin" ];

  home.pointerCursor = {
    package = pkgs.capitaine-cursors;
    name = "capitaine-cursors";
    size = 24;
  };

  home.packages = with pkgs; [
    gnumake
    gcc
    cargo
    nodejs
    python3
    unzip
    p7zip
    trash-cli
    ripgrep
    fd
    xclip
    xcolor
    maim
    chafa
    ffmpeg
    mpc-cli
    brightnessctl
    mongosh
    papirus-icon-theme
    keepassxc
    fceux
    telegram-desktop

    ## formatter
    jq
    html-tidy
    stylua
    nodePackages.prettier

    ## LSP server
    lua-language-server
    nodePackages.vscode-langservers-extracted
    nodePackages.typescript-language-server
  ];


  # home.file = {
  #   ".xinitrc" = {
  #     text = ''
  #       #!/bin/sh

  #       ## https://nixos.wiki/wiki/Using_X_without_a_Display_Manager
  #       ## FIX: dbus-daemon
  #       if test -z "$DBUS_SESSION_BUS_ADDRESS"; then
  #         eval $(dbus-launch --exit-with-session --sh-syntax)
  #       fi
  #       systemctl --user import-environment DISPLAY XAUTHORITY
  #       if command -v dbus-update-activation-environment >/dev/null 2>&1; then
  #         dbus-update-activation-environment DISPLAY XAUTHORITY
  #       fi

  #       systemctl --user start graphical-session.target

  #       xset r rate 200 30
  #       xsetroot -cursor_name left_ptr
  #       feh --no-fehbg --bg-fill $XDG_DATA_HOME/wallpapers/gruvbox_pacman.png &
  #       # polybar -rq -c $XDG_CONFIG_HOME/polybar/config.ini foobar &
  #       exec bspwm

  #       ## run() { ! pgrep -x "$1" > /dev/null && "$@"; }
  #       ## run picom --daemon &
  #       ## run fcitx5 -d &
  #       ## run dunst &
  #       ## run sxhkd &
  #     '';
  #   };
  # };

  xdg.dataFile = {
    "fcitx5/rime" = {
      source = ../extras/rime;
      recursive = true;
    };
  };

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    extraConfig = {
      XDG_WORKSPACES_DIR = "${config.home.homeDirectory}/Workspaces";
    };
  };

  # FIX: fceux.desktop
  xdg.desktopEntries = {
    fceux = {
      name = "Fceux";
      genericName = "NES/Famicom emulator";
      exec = "fceux";
      terminal = false;
      categories = [ "Game" "Emulator" ];
      mimeType = [ "application/x-nes-rom" ];
      icon = "fceux";
    };
  };

  xsession.enable = true;

  # xsession.windowManager.bspwm = {
  #   enable = true;
  #   monitors = {
  #     eDP-1 = [ "1" "2" "3" "4" "5" ];
  #   };
  #   rules = {
  #     "kitty" = {
  #       desktop = "^1";
  #       follow = true;
  #     };
  #     "Chromium-browser" = {
  #       desktop = "^2";
  #       follow = true;
  #     };
  #   };
  #   settings = {
  #     window_gap = 5;
  #     top_padding = 0;
  #     right_padding = 0;
  #     bottom_padding = 0;
  #     left_padding = 0;
  #     border_width = 3;
  #     normal_border_color = "#32302f";
  #     focused_border_color = "#689d6a";
  #     split_ratio = 0.50;
  #     borderless_monocle = true;
  #     gapless_monocle = true;
  #   };
  #   startupPrograms = [
  #     "pgrep -x sxhkd > /dev/null || sxhkd"
  #   ];
  # };

  services.syncthing.enable = true;

  # services.sxhkd = {
  #   enable = true;
  #   extraConfig = ''
  #     super + w
  #       bspc node focused --close
  #     super + {t,shift + t,f,shift + f}
  #       bspc node --state {tiled,pseudo_tiled,floating,fullscreen}
  #     super + {j,k}
  #       bspc node focused --focus {next,prev}.leaf.local.!hidden
  #     super + shift + {j,k}
  #       bspc node focused --swap {next,prev}.leaf.local.!hidden
  #     super + {h,l}
  #       bspc desktop focused --focus {prev,next}.local
  #     super + shift + {h,l}
  #       bspc node focused --to-desktop {prev,next}.local --follow

  #     super + s
  #       bspc node focused --swap biggest.leaf.local.!hidden

  #     super + {_,shift + }{1-5}
  #       bspc {desktop -f,node -d} '^{1-5}'

  #     super + alt + {h,j,k,l}
  #       bspc node -z {left -20 0,bottom 0 20,top 0 -20,right 20 0}

  #     super + ctrl + {h,j,k,l}
  #       bspc node -z {right -20 0,top 0 20,bottom 0 -20,left 20 0}

  #     super + {comma,period,slash}
  #       amixer sset Master {5%-,5%+,toggle}

  #     super + shift + {comma,period}
  #       brightnessctl set 5%{-,+}

  #     super + Escape
  #       pkill -USR1 -x sxhkd

  #     super + Return
  #       kitty

  #     super + shift + Return
  #       rofi -show drun

  #     super + shift + c
  #       dunstctl close

  #     super + {_,shift + }p
  #       maim {-s ,_}~/Pictures/(date +%s).png
  #   '';
  # };

  # services.picom = {
  #   enable = true;
  #   backend = "glx";
  #   fade = true;
  #   fadeSteps = [ 0.5 0.5 ];
  #   shadow = true;
  #   activeOpacity = 1;
  #   settings = {
  #     blur = {
  #       # method = "gaussian"; size = 10; deviation = 5.0;
  #       method = "dual_kawase";
  #       strength = 5;
  #     };
  #     blur-background-exclude = [
  #       "class_g = 'slop'"
  #     ];
  #   };
  # };

  # services.dunst = {
  #   enable = true;
  #   iconTheme = {
  #     name = "Papirus";
  #     package = pkgs.papirus-icon-theme;
  #   };
  #   settings = {
  #     global = {
  #       frame_color = "#689d6a";
  #       width = "(0,300)";
  #       height = 300;
  #       offset = "15x15";
  #       icon_theme = "Papirus";
  #       min_icon_size = 48;
  #       max_icon_size = 128;
  #     };
  #     urgency_low = {
  #       background = "#282828";
  #       foreground = "#ebdbb2";
  #       timeout = 3;
  #     };
  #     urgency_normal = {
  #       background = "#282828";
  #       foreground = "#ebdbb2";
  #       timeout = 5;
  #     };
  #     urgency_critical = {
  #       background = "#282828";
  #       foreground = "#ebdbb2";
  #       timeout = 0;
  #     };
  #   };
  # };

  services.mpd = {
    enable = true;
    musicDirectory = "/run/media/philopence/MUSIC";
    extraConfig = ''
      audio_output {
        type            "pulse"
        name            "pulse audio"
      }
    '';
  };

  programs.zathura.enable = true;

  programs.fish = {
    enable = true;
    functions = {
      fish_greeting = {
        body = "";
      };
    };
    plugins = [
      {
        name = "z";
        src = pkgs.fetchFromGitHub {
          owner = "jethrokuan";
          repo = "z";
          rev = "85f863f20f24faf675827fb00f3a4e15c7838d76";
          sha256 = "sha256-+FUBM7CodtZrYKqU542fQD+ZDGrd2438trKM0tIESs0=";
        };
      }
      ###########################
      {
        name = "done";
        src = pkgs.fetchFromGitHub {
          owner = "franciscolourenco";
          repo = "done";
          rev = "ed73dd4059827ea1a0381e048c162c71d521f884";
          sha256 = "sha256-6oeyN9ngXWvps1c5QAUjlyPDQwRWAoxBiVTNmZ4sG8E=";
        };
      }
    ];
  };

  programs.chromium = {
    enable = true;
    extensions = [
      { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # ublock origin
      { id = "aapbdbdomjkkjkaonfhkkikfgjllcleb"; } # google translate
    ];
  };

  programs.exa = {
    enable = true;
    enableAliases = true;
  };

  # programs.feh.enable = true;

  # programs.neovim.enable = true;

  programs.fzf.enable = true;

  programs.bat.enable = true;

  programs.lazygit.enable = true;

  programs.btop.enable = true;

  programs.lf.enable = true;

  programs.home-manager.enable = true;

  # programs.git = {
  #   enable = true;
  #   extraConfig = {
  #     init = {
  #       defaultBranch = "master";
  #     };
  #     user = {
  #       email = "epcroo@yeah.net";
  #       name = "philopence";
  #     };
  #   };
  # };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "22.11";
}
