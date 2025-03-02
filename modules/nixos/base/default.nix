# Base NixOS configuration that applies to all hosts
{ config, pkgs, lib, ... }:

{
  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking.networkmanager.enable = true;
  
  # Locale and keyboard settings
  console.keyMap = "es";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_ES.UTF-8";
    LC_IDENTIFICATION = "es_ES.UTF-8";
    LC_MEASUREMENT = "es_ES.UTF-8";
    LC_MONETARY = "es_ES.UTF-8";
    LC_NAME = "es_ES.UTF-8";
    LC_NUMERIC = "es_ES.UTF-8";
    LC_PAPER = "es_ES.UTF-8";
    LC_TELEPHONE = "es_ES.UTF-8";
    LC_TIME = "es_ES.UTF-8";
  };

  # X11 keymap
  services.xserver.xkb = {
    layout = "es";
    variant = "winkeys";
  };

  # Enable flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Base packages every system should have
  environment.systemPackages = with pkgs; [
    fish # shell
    vim # Editor
    git # Version control
    curl wget # Network utilities
    unzip # Archive tool
    tree
    htop
    neofetch
  ];

  # Enable fish 
  programs.fish.enable = true;

  # SSH system configuration
  programs.ssh = {
    startAgent = false;  # We'll use Home Manager's SSH agent instead
  };

  # Enable OpenSSH
  services.openssh.enable = true;
}
