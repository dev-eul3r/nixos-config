# hyprlock/default.nix
{ config, pkgs, lib, inputs, ... }:

{
  # Enable Hyprlock
  programs.hyprlock = {
    enable = true;
    
    # All configuration should be under settings
    settings = {
      # General settings
      general = {
        disable_loading_bar = false;
        hide_cursor = true;
        grace = 0; # No grace period - immediately ask for password
        no_fade_in = false;
      };
      
      # Background settings - keeping your existing wallpaper
      background = [
        {
          monitor = "";
          path = "~/Pictures/sails.jpeg"; # Keeping your existing wallpaper
          color = "rgba(25, 20, 20, 1.0)";
          blur_size = 4;
          blur_passes = 3;
          noise = 0.0117;
          brightness = 0.8;
        }
      ];
      
      # Clock/time widget - moved up in the configuration to appear before input field
      label = [
        # Large clock display
        {
          monitor = "";
          text = "$TIME";
          color = "rgba(242, 243, 244, 0.75)";
          font_size = 95;
          font_family = "Hack Nerd Font";
          position = "0, 300"; # Position clock higher on screen
          halign = "center";
          valign = "center";
        }
        # Date display with explicit English locale
        {
          monitor = "";
          text = ''cmd[update:1000] echo "$(LC_ALL=en_US.UTF-8 date +"%A, %B %d")"'';
          color = "rgba(242, 243, 244, 0.75)";
          font_size = 22;
          font_family = "Hack Nerd Font";
          position = "0, 200"; # Position date under the clock
          halign = "center";
          valign = "center";
        }
      ];
      
      # Input field configuration - moved below time/date
      "input-field" = [
        {
          monitor = "";
          size = "200, 50";
          outline_thickness = 2;
          dots_size = 0.2; 
          dots_spacing = 0.35;
          dots_center = true;
          outer_color = "rgba(0, 0, 0, 0)"; # Transparent outer color
          inner_color = "rgba(0, 0, 0, 0.2)"; # Subtle inner color
          font_color = "rgb(242, 243, 244)";
          fade_on_empty = false;
          rounding = -1; # Match example's design
          placeholder_text = "";
          hide_input = false;
          position = "0, -100"; # Position input field below date/time
          halign = "center";
          valign = "center";
          check_color = "rgb(30, 107, 204)"; # Blue for correct input
          fail_color = "rgb(204, 34, 34)"; # Red for incorrect input
        }
      ];
    };
  };
}
