{
  description = "Modules for NixOS distros";

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

      raspi4 = { pkgs, ... }: {
        boot.loader.grub.enable = false;
        boot.loader.generic-extlinux-compatible.enable = true;
        boot.kernelPackages = pkgs.linuxPackages_rpi4;
      };

      mdns = { config, pkgs, ... }: {
        # Enable mdns ( nixos.local )
        services.nscd.enable = true;
        services.resolved.enable = true;
        services.avahi.enable = true;
        services.avahi.publish.enable = true;
        services.avahi.publish.userServices = true;


        # What worked on my network was the snippet below
        # from https://nixos.wiki/wiki/Printing
        # "... mdns does not work properly with IPv6 in your network"
        #
        services.avahi.nssmdns = false; # Use the settings from below
        # settings from avahi-daemon.nix where mdns is replaced with mdns4
        system.nssModules = with pkgs.lib; optional (!config.services.avahi.nssmdns) pkgs.nssmdns;
        system.nssDatabases.hosts = with pkgs.lib; optionals (!config.services.avahi.nssmdns) (mkMerge [
          (mkOrder 900 [ "mdns4_minimal [NOTFOUND=return]" ]) # must be before resolve
          (mkOrder 1501 [ "mdns4" ]) # 1501 to ensure it's after dns
        ]);
      };

    };
  };
}
