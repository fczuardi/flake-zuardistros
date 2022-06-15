# flakes-zuardistros

Configs for building machines... powered by NixOS Flakes.

## Usage

Pick and choose what `nixosModules` you need.

Example of a raspberry pi with NixOs ( /etc/nixos/flake.nix ):
```
{
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs;
    zuardistros.url = github:fczuardi/flakes-zuardistros;
    zuardistros.inputs.nixpkgs.follows = "nixpkgs";
  };
  
  outputs = { self, nixpkgs, zuardistros, ... }@attrs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      specialArgs = attrs;
      modules = [ 
        ./configuration.nix
        zuardistros.nixosModules.flakes
        zuardistros.nixosModules.git
        zuardistros.nixosModules.raspi4
        zuardistros.nixosModules.mdns
      ];
    };
  };
}
```
