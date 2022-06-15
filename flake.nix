{
  description = "My Nix OS distros";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-22.05;
  };

  outputs = { nixpkgs, ... }: {
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;

    nixosModules = {
      git = { pkgs, ... }: {
        environment.systemPackages = with pkgs; [ git ];
        programs.git.enable = true;
        programs.git.config.init.defaultBranch = "main";
      };
    };
  };
}
