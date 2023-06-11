{ inputs, outputs, lib, config, pkgs, ... }: {

  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;

  users = {
    defaultUserShell = pkgs.fish; ## programs.fish.enable = true;
    users = {
      philopence = {
        isNormalUser = true;
        hashedPassword = "$y$j9T$Jx74QkZkErbc4rap1Sa5Y.$n1ji/UcUIdBxXt851e162MVgw8zXXOPyK9KFG36dKJ/";
        extraGroups = [ "wheel" ];
      };
    };
  };

  networking = {
    hostName = "nixos"; ## TODO: retro
    networkmanager = {
      enable = true;
    };
    firewall = {
      allowedTCPPorts = [ 2017 ]; ## for v2raya
    };
  };

  hardware.pulseaudio.enable = true;

  time.timeZone = "Asia/Shanghai";

  i18n = {
    inputMethod = {
      enabled = "fcitx5";
      fcitx5 = {
        addons = with pkgs; [ fcitx5-rime ];
      };
    };
  };

  fonts = {
    fonts = with pkgs; [
      (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
      cascadia-code
      recursive
      #noto-fonts-cjk-sans
      #noto-fonts-cjk-serif
    ];
    enableDefaultFonts = true;
    fontconfig = {
      hinting = {
        autohint = true;
      };
      #defaultFonts = {
      #  serif = [ "Noto Serif" "Noto Serif CJK SC" ];
      #  sansSerif = [ "Noto Sans" "Noto Sans CJK SC" ];
      #  monospace = [ "Noto Sans Mono" "Noto Sans Mono CJK SC" ];
      #  emoji = [ "Noto Color Emoji" ];
      #};
    };
  };

  services = {
    xserver = {
      enable = true;
      # desktopManager.runXdgAutostartIfNone = true;
      desktopManager.wallpaper.mode = "fill";
      desktopManager.gnome.enable = true;
      # windowManager.bspwm.enable = true;
      displayManager = {
        # defaultSession = "none+bspwm";
        lightdm.enable = true;
        # startx.enable = true; ## ~/.xinitrc
      };
      libinput.touchpad.naturalScrolling = true;
    };
    udisks2 = {
      enable = true;
      mountOnMedia = true;
    };
    v2raya.enable = true;
  };

  ## TODO: GTK/QT

  programs.fish.enable = true;

  ## TODO: variables
  programs.git = {
    enable = true;
    config = {
      init = {
        defaultBranch = "master";
      };
      user = {
        email = "epcroo@yeah.net";
        name = "philopence";
      };
    };
  };

  # programs.neovim.enable = true;
  # programs.neovim.defaultEditor = true;

  ## TODO: test
  programs.dconf.enable = true;

  programs.npm = {
    enable = true;
    npmrc = ''
      prefix = ''${XDG_DATA_HOME}/npm
      cache = ~/.cache/npm
      registry = https://registry.npmmirror.com
    '';
  };

  environment.systemPackages = with pkgs; [
    feh
    neovim
  ];

  nix = {
    settings = {
      # substituters = [ "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store" ];
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
    };
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "22.11";
}
