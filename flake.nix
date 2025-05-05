{
  description = "My flakes!";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ...}@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "X86_64-linux";
      modules = [
      ./configuration.nix
      ];
    };
  };
}
