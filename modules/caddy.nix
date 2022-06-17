{ config, ... }: {
  # Caddy webserver
  services.caddy = {
    enable = true;
    globalConfig = ''
      auto_https disable_redirects
    '';
    extraConfig = ''
      https://${config.networking.hostName}.local {
        root * ${config.services.caddy.dataDir}
        file_server
      }
    '';
  };
  networking.firewall.allowedTCPPorts = [ 443 ];
}
