# Main Home Manager configuration
{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    # Import modular configurations
    ./alacritty
    ./fish
    ./hyprland
    ./hyprlock
    ./neovim
    ./waybar
    ./ssh
    ./development
  ];

  # Home Manager needs a bit of information about you and the paths it should manage
  home.username = "eul3r";
  home.homeDirectory = "/home/eul3r";

  # Set state version
  home.stateVersion = "24.11";

  # Install base packages
  home.packages = with pkgs; [
    nerd-fonts.hack
    eza
    fzf
    qbittorrent
    vlc
  ];

  # Environment variables
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Enable Home Manager
  programs.home-manager.enable = true;
}
