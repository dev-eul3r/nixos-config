# User configuration
{ config, pkgs, lib, inputs, ... }:

{
  # Define user account
  users.users.eul3r = {
    isNormalUser = true;
    description = "eul3r";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.fish;
    packages = with pkgs; [];
  };

  # Home Manager configuration
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "eul3r" = import ../../../modules/home-manager;
    };
    backupFileExtension = "backup";
    useGlobalPkgs = true;
    useUserPackages = true;
  };
}
