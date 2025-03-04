# Hyprland configuration
{ config, pkgs, inputs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.variables = ["--all"];
    settings = {
      "$mod" = "SUPER";

      bind = [
        # Terminal
        "$mod, Return, exec, alacritty"

        # Kill focused window
        "$mod SHIFT, Q, killactive,"

        # Exit Hyprland
        "$mod SHIFT, E, exit,"

        # File manager
        "$mod, N, exec, thunar"

        # Toggle floating
        "$mod, Shift+Space, togglefloating,"

        # Application launcher
        "$mod, D, exec, rofi -modi drun -show drun -config ~/.config/rofi/rofidmenu.rasi"

        # Window switcher
        "$mod, T, exec, rofi -show window -config ~/.config/rofi/rofidmenu.rasi"

        # Screenshots
        ", Print, exec, grimblast copy area"

        # Lock screen
        "$mod, X, exec, hyprlock"

        # Browser
        "$mod, B, exec, google-chrome-stable"

        # Focus movement
        "$mod, H, movefocus, l"
        "$mod, J, movefocus, d"
        "$mod, K, movefocus, u"
        "$mod, L, movefocus, r"

        # Move focused window
        "$mod SHIFT, H, movewindow, l"
        "$mod SHIFT, J, movewindow, d"
        "$mod SHIFT, K, movewindow, u"
        "$mod SHIFT, L, movewindow, r"

        # Fullscreen
        "$mod, F, fullscreen,"

        # Toggle tiling / floating
        "$mod, Space, togglefloating,"

        # Workspace switching
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"

        # Move focused window to workspace
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod SHIFT, 0, movetoworkspace, 10"

        # Multimedia keys
        ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ", XF86MonBrightnessUp, exec, brightnessctl s 10%+"
        ", XF86MonBrightnessDown, exec, brightnessctl s 10%-"

        # Player controls
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPrev, exec, playerctl previous"
      ];

      monitor = [
        "HDMI-1, preferred, auto, auto"
        "eDP-1, 1920x1080@144, auto, 1"
      ];

      workspace = [
        "1, monitor:HDMI-1"
        "2, monitor:HDMI-1"
        "3, monitor:HDMI-1"
        "4, monitor:HDMI-1"
        "5, monitor:HDMI-1"
        "6, monitor:HDMI-1"
        "7, monitor:eDP-1"
        "8, monitor:eDP-1"
        "9, monitor:eDP-1"
        "10, monitor:eDP-1"
      ];

      general = {
        gaps_in = 4;
        gaps_out = 4;
        border_size = 2;
        layout = "dwindle";
      };

      input = {
        kb_layout = "es";
      };

      decoration = {
        rounding = 10;
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
        };
      };

      animations = {
        enabled = true;
        bezier = "easeOutQuint, 0.23, 1, 0.32, 1";
        animation = [
          "windows, 1, 4.79, easeOutQuint"
          "fade, 1, 3.03, default"
          "workspaces, 1, 1.94, default"
        ];
      };

      exec-once = [
	    "systemctl --user restart waybar && nm-applet --indicator" # start waybar
	    "swww-daemon && swww img ~/Pictures/sails.jpeg"
      ];
    };
  };
}
