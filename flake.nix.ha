{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # add more inputs if needed
  };

  outputs = { self, nixpkgs, ... }: {
    nixosConfigurations = {
      mySystem = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          # add other modules or configurations here
        ];
      };
    };
  };
}
