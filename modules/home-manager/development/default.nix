# Development environment configuration
{ config, pkgs, lib, ... }:

{
  # Enable direnv for automatic environment switching
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  # Install basic development tools
  home.packages = with pkgs; [
  ];
}  
