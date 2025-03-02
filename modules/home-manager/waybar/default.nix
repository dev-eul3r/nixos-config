# Waybar configuration
{ config, pkgs, lib, ... }:

{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    style = ''
      * {
        font-family: "Hack Nerd Font", "Font Awesome 6 Free";
        font-size: 13px;
        min-height: 0;
      }

      window#waybar {
        background: rgba(21, 18, 27, 0.8);
        color: #cdd6f4;
        border-radius: 8px;
      }

      tooltip {
        background: #1e1e2e;
        border-radius: 8px;
        border: 2px solid #313244;
      }

      #workspaces button {
        padding: 5px;
        color: #a6adc8;
        background: none;
        border: none;
        box-shadow: none;
        text-shadow: none;
        transition: all 0.3s ease-in-out;
        border-radius: 0;
      }

      #workspaces button.active {
        color: #f5e0dc;
        background: #313244;
        border-radius: 4px;
        box-shadow: rgba(0, 0, 0, 0.2) 0 0 4px 2px;
      }

      #workspaces button:hover {
        background: rgba(49, 50, 68, 0.4);
        border-radius: 4px;
      }

      #clock,
      #battery,
      #cpu,
      #memory,
      #disk,
      #temperature,
      #backlight,
      #network,
      #pulseaudio,
      #custom-media,
      #tray,
      #mode,
      #idle_inhibitor,
      #mpd {
        padding: 0 10px;
        margin: 0 4px;
        color: #cdd6f4;
        border-radius: 8px;
        background: #1e1e2e;
      }

      #battery.charging, #battery.plugged {
        color: #a6e3a1;
      }

      #battery.critical:not(.charging) {
        background-color: #f38ba8;
        color: #1e1e2e;
        animation-name: blink;
        animation-duration: 0.5s;
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }

      #network.disconnected {
        background-color: #f38ba8;
        color: #1e1e2e;
      }

      @keyframes blink {
        to {
          background-color: #cdd6f4;
          color: #1e1e2e;
        }
      }
    '';
    
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        spacing = 4;
        margin-top = 6;
        margin-left = 8;
        margin-right = 8;
        
        modules-left = [
          "hyprland/workspaces"
          "hyprland/mode"
          "hyprland/window"
        ];
        
        modules-center = [
          "clock"
        ];
        
        modules-right = [
          "pulseaudio"
          "cpu"
          "memory"
          "network"
          "battery"
          "tray"
        ];
        
        "hyprland/workspaces" = {
          format = "{name}";
          active-only = false;
          all-outputs = true;
          on-click = "activate";
        };
        
        "clock" = {
          format = "{:%H:%M}";
          format-alt = "{:%Y-%m-%d %H:%M}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          interval = 1;
        };
        
        "cpu" = {
          format = "CPU {usage}%";
          tooltip = true;
          interval = 2;
        };
        
        "memory" = {
          format = "MEM {}%";
          interval = 2;
        };
        
        "battery" = {
          bat = "BAT0";
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-charging = " {capacity}%";
          format-plugged = " {capacity}%";
          format-alt = "{icon} {time}";
          format-icons = ["" "" "" "" ""];
          interval = 10;
        };
        
        "network" = {
          format-wifi = " {essid}";
          format-ethernet = " {ipaddr}/{cidr}";
          format-linked = " {ifname} (No IP)";
          format-disconnected = "Disconnected";
          format-alt = "{ifname}: {ipaddr}/{cidr}";
          tooltip-format = "{ifname} via {gwaddr}";
          interval = 5;
        };
        
        "pulseaudio" = {
          format = "{icon} {volume}%";
          format-muted = " Muted";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = ["" "" ""];
          };
          on-click = "pavucontrol";
        };
        
        "tray" = {
          icon-size = 21;
          spacing = 10;
        };
      };
    };
  };

  # Install additional dependencies that Waybar might need
  home.packages = with pkgs; [
    font-awesome      # Icon font
    pavucontrol       # GUI for audio control
    networkmanagerapplet # Network manager tray icon
  ];
}
