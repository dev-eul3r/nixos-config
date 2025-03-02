{
  description = "NixOS configuration with Home Manager";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:nixos/nixos-hardware/master";
    
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixos-hardware, home-manager, hyprland, ... }@inputs: 
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      
      lib = nixpkgs.lib;
    in {
      nixosConfigurations = {
        home = lib.nixosSystem { 
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/home/configuration.nix
            nixos-hardware.nixosModules.asus-rog-strix-g513im
            inputs.home-manager.nixosModules.default
          ];
        };
      };
    };
}
