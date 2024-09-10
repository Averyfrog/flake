{
  description = "Avery's very bad flake :3";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    #nixpkgs.url = "https://github.com/Guanran928/nixpkgs/commits/nixos-unstable";
    
    #nixpkgs_patched.url = "github:nixos/nixpkgs/468a37e6ba01c45c91460580f345d48ecdb5a4db";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";    
      };

    hyprland = {
      url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    };

    nixcord = {
      url = "github:kaylorben/nixcord";
    };

    stylix = {
      url = "github:danth/stylix";
    };
  };

  outputs = {self, nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations.default = nixpkgs.lib.nixosSystem {
          specialArgs = {inherit inputs;};
          modules = [ 
            ./configuration.nix
            inputs.home-manager.nixosModules.home-manager
            inputs.stylix.nixosModules.stylix
          ];
        };
    };
}