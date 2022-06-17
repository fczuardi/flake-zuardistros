{
  flakes = import ./flakes.nix;
  git = import ./git.nix;
  raspi4 = import ./raspi4.nix;
  mdns = import ./mdns.nix;
  caddy = import ./caddy.nix;
}
