# Desktop environment configuration
{ config, pkgs, lib, inputs, ... }:

{
  # Enable Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    package = inputs.hyprland.packages."${pkgs.system}".hyprland;
  };

  # Enable display manager
  services.xserver.displayManager.gdm = {
    enable = true;
    wayland = true;
  };


  # Environment variables for Wayland
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  # Desktop applications
  environment.systemPackages = with pkgs; [
    # Terminal emulators
    alacritty
    
    # Web browsers
    google-chrome

    # hyprland utilities
    waybar              # Status bar
    swww                # Wallpaper daemon
    rofi-wayland        # Application launcher
    wl-clipboard        # Clipboard manager
    grimblast           # Screenshot utility 
    hyprlock		# Lock Screen
    brightnessctl       # Brightness control
    networkmanagerapplet # Network manager applet
  ];
}
