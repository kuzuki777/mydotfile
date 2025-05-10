{
  description = "My flakes!";

  inputs = {

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.11";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-stable, home-manager, ...}:
  let
    lib = nixpkgs.lib;
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    nixosConfigurations = {
      nixos = lib.nixosSystem {
        #system = "x86_64-linux";
        inherit system;
	modules = [
          ./configuration.nix
        ];
      };
    };
    homeConfigurations = {
      mark = home-manager.lib.homeManagerConfiguration {
        #system = "x86_64-linux";
        inherit pkgs;
	modules = [ ./home.nix ];
      };
    };
  };
}
