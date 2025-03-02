# Main configuration for the 'home' host
{ config, pkgs, inputs, lib, ... }:

{
  imports = [
    # Include the generated hardware configuration
    ./hardware-configuration.nix
    # Include base system configuration
    ../../modules/nixos/base
    # Include desktop environment configuration
    ../../modules/nixos/desktop
    # Include user configuration
    ../../modules/nixos/user
  ];

  # Machine-specific configuration
  networking.hostName = "nixos";
  time.timeZone = "Europe/Madrid";
  
  # LUKS encryption
  boot.initrd.luks.devices."luks-017215f4-f780-4095-b658-ddd19a911aae".device = "/dev/disk/by-uuid/017215f4-f780-4095-b658-ddd19a911aae";

  # Set system state version
  system.stateVersion = "24.11";
}
