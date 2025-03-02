# Alacritty terminal configuration
{ config, pkgs, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      general = {
        live_config_reload = true;
      };

      bell = {
        animation = "EaseOutExpo";
        color = "0xffffff";
        duration = 0;
      };

      colors = {
        draw_bold_text_with_bright_colors = false;

        bright = {
          black = "0x6e6a86";
          blue = "0x9ccfd8";
          cyan = "0xebbcba";
          green = "0x31748f";
          magenta = "0xc4a7e7";
          red = "0xeb6f92";
          white = "0xe0def4";
          yellow = "0xf6c177";
        };

        cursor = {
          cursor = "0x524f67";
          text = "0xe0def4";
        };

        hints = {
          end = {
            background = "#1f1d2e";
            foreground = "#6e6a86";
          };
          start = {
            background = "#1f1d2e";
            foreground = "#908caa";
          };
        };

        line_indicator = {
          background = "None";
          foreground = "None";
        };

        normal = {
          black = "0x26233a";
          blue = "0x9ccfd8";
          cyan = "0xebbcba";
          green = "0x31748f";
          magenta = "0xc4a7e7";
          red = "0xeb6f92";
          white = "0xe0def4";
          yellow = "0xf6c177";
        };

        primary = {
          background = "0x191724";
          foreground = "0xe0def4";
        };

        selection = {
          background = "0x403d52";
          text = "0xe0def4";
        };

        vi_mode_cursor = {
          cursor = "0x524f67";
          text = "0xe0def4";
        };
      };

      cursor = {
        style = "Block";
        unfocused_hollow = true;
      };

      debug = {
        log_level = "OFF";
        persistent_logging = false;
        print_events = false;
        render_timer = false;
      };

      env = {
        TERM = "tmux-256color";
      };

      font = {
        size = 12.0;

        bold = {
          family = "HackNerdFont";
          style = "Bold";
        };

        glyph_offset = {
          x = 0;
          y = 0;
        };

        italic = {
          family = "HackNerdFont";
          style = "Italic";
        };

        normal = {
          family = "HackNerdFont";
          style = "Regular";
        };

        offset = {
          x = 0;
          y = 0;
        };
      };

      mouse = {
        hide_when_typing = true;
      };

      keyboard.bindings = [
        {
          action = "Paste";
          key = "V";
          mods = "Command";
        }
        {
          action = "Copy";
          key = "C";
          mods = "Command";
        }
        {
          action = "Quit";
          key = "Q";
          mods = "Command";
        }
      ];

      mouse.bindings = [
        {
          action = "PasteSelection";
          mouse = "Middle";
        }
      ];

      scrolling = {
        history = 10000;
        multiplier = 3;
      };

      selection = {
        save_to_clipboard = true;
        semantic_escape_chars = ",│`|:\"' ()[]{}<>";
      };

      terminal.shell = {
        program = "fish";
      };

      window = {
        decorations = "full";
        dynamic_padding = true;
        opacity = 0.9;  
        startup_mode = "Windowed";

        dimensions = {
          columns = 100;
          lines = 85;
        };

        padding = {
          x = 0;
          y = 0;
        };
      };
    };
  };
}
