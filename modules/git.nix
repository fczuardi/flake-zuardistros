{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ git ];
  programs.git.enable = true;
  programs.git.config.init.defaultBranch = "main";
}
