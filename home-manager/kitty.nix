{ inputs, outputs, lib, config, pkgs, ... }: {
  programs.kitty = {
    enable = true;
    settings = {
      ##############################
      # font_family = "Rec Mono Casual";
      # bold_font = "Rec Mono Casual Bold";
      # italic_font = "Rec Mono Casual Italic";
      # bold_italic_font = "Rec Mono Casual Bold Italic";

      # font_family = "Cartograph CF Regular";
      # bold_font = "Cartograph CF Bold";
      # italic_font = "Cartograph CF Regular Italic";
      # bold_italic_font = "Cartograph CF Bold Italic";

      font_family = "Cascadia Code Regular";
      bold_font = "Cascadia Code Bold";
      italic_font = "Cascadia Code Italic";
      bold_italic_font = "Cascadia Code Bold Italic";

      # font_family = "JetBrains Mono Regular";
      # bold_font = "JetBrains Mono Bold";
      # italic_font = "JetBrains Mono Italic";
      # bold_italic_font = "JetBrains Mono Bold Italic";

      "modify_font baseline" = 0;
      "modify_font cell_height" = "1.5";
      font_size = 10;
      symbol_map = "U+E000-U+E00D,U+e0a0-U+e0a2,U+e0b0-U+e0b3,U+e0a3-U+e0a3,U+e0b4-U+e0c8,U+e0cc-U+e0d2,U+e0d4-U+e0d4,U+e5fa-U+e62b,U+e700-U+e7c5,U+f000-U+f2e0,U+e200-U+e2a9,U+f400-U+f4a8,U+2665-U+2665,U+26A1-U+26A1,U+f27c-U+f27c,U+F300-U+F313,U+23fb-U+23fe,U+2b58-U+2b58,U+f500-U+fd46,U+e300-U+e3eb Symbols Nerd Font Mono";
      window_padding_width = 0;
      background_opacity = "1";
      clear_all_shortcuts = "no";
      enabled_layouts = "splits";
      cursor_shape = "beam";
      foreground               = "#ebdbb2";
      background               = "#282828";
      selection_foreground     = "#ebdbb2";
      selection_background     = "#504945";
      cursor                   = "#d65d0e";
      cursor_text_color        = "#282828";
      url_color                = "#b16286";
      active_border_color      = "#689d6a";
      inactive_border_color    = "#3c3836";
      bell_border_color        = "#cc241d";
      active_tab_foreground    = "#282828";
      active_tab_background    = "#689d6a";
      inactive_tab_foreground  = "#928374";
      inactive_tab_background  = "#3c3836";
      color0  = "#1d2021";
      color8  = "#3c3836";
      color1  = "#cc241d";
      color9  = "#fb4934";
      color2  = "#98971a";
      color10 = "#b8bb26";
      color3  = "#d79921";
      color11 = "#fabd2f";
      color4  = "#458588";
      color12 = "#83a598";
      color5  = "#b16286";
      color13 = "#d3869b";
      color6  = "#689d6a";
      color14 = "#8ec07c";
      color7  = "#d5c4a1";
      color15 = "#fbf1c7";
      color16 = "#d65d0e";
      color17 = "#fe8019";
    };
    extraConfig = ''
    font_features CascadiaCode-Regular +ss02 +ss19 +ss20
    font_features CascadiaCode-Bold +ss02 +ss19 +ss20
    font_features CascadiaCode-Italic +ss01 +ss02 +ss03 +ss19 +ss20
    font_features CascadiaCode-BoldItalic +ss01 +ss02 +ss03 +ss19 +ss20
    '';
    keybindings = {
      ### window ###
      "kitty_mod+enter" = "launch --location=split --cwd=current";
      "kitty_mod+j" = "next_window";
      "kitty_mod+k" = "previous_window";
      ### tab ###
      "kitty_mod+t" = "new_tab_with_cwd";
      "kitty_mod+h" = "previous_tab";
      "kitty_mod+l" = "next_tab";
    };
  };
}
