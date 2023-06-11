{ inputs, outputs, lib, config, pkgs, ... }: {

  programs.rofi = {
    enable = true;
    extraConfig = {
      font = "Rec Mono Duotone 10";
      modes = "window,drun,run";
      show-icons = true;
      icon-theme = "Papirus";
      drun-display-format = "{name}";
      display-drun = "";
    };
    theme =
      let
        inherit (config.lib.formats.rasi) mkLiteral;
      in
      {
        "*" = {
          base00 = mkLiteral "#1D2021";
          base01 = mkLiteral "#282828";
          base02 = mkLiteral "#32302f";
          base03 = mkLiteral "#504945";
          base04 = mkLiteral "#928374";
          base05 = mkLiteral "#D5C4A1";
          base06 = mkLiteral "#EBDBB2";
          base07 = mkLiteral "#FBF1C7";
          # base08: ;
          base09 = mkLiteral "#d65d0e";
          base0A = mkLiteral "#cc241d";
          base0B = mkLiteral "#98971a";
          base0C = mkLiteral "#d79921";
          base0D = mkLiteral "#458588";
          base0E = mkLiteral "#b16286";
          base0F = mkLiteral "#689d6a";
          selected = mkLiteral "bold #EBDBB2";
        };
        "window" = {
          width = mkLiteral "600px";
        };
        "mainbox" = {
          background-color = mkLiteral "@base00";
          padding = mkLiteral "20px";
        };
        "inputbar" = {
          background-color = mkLiteral "@base0D";
          children = map mkLiteral [ "prompt" "entry" ];
        };
        "prompt" = {
          font = "Symbols Nerd Font Mono 20";
          background-color = mkLiteral "@base0D";
          text-color = mkLiteral "@base01";
          padding = mkLiteral "0 25px";
          vertical-align = mkLiteral "0.5";
        };
        "entry" = {
          background-color = mkLiteral "@base02";
          padding = mkLiteral "0 0 0 20px";
          text-color = mkLiteral "@base06";
          vertical-align = mkLiteral "0.5";
        };
        "listview" = {
          background-color = mkLiteral "@base00";
          columns = 2;
          lines = 7;
          padding = mkLiteral "20px 0 0 0";
        };
        "element" = {
          background-color = mkLiteral "@base00";
          text-color = mkLiteral "@base06";
        };
        "element-icon, element-text" = {
          background-color = mkLiteral "inherit";
          text-color = mkLiteral "inherit";
          text-style = mkLiteral "bold";
          #highlight = mkLiteral "underline red";
          padding = mkLiteral "5px";
          vertical-align = mkLiteral "0.5";
        };
        "element-icon" = {
          size = mkLiteral "24px";
        };
        "element selected.normal" = {
          background-color = mkLiteral "@base03";
          text-color = mkLiteral "@base06";
        };
      };
  };
}
