{ config, lib, ... }:
{
  options.modules.virtualHosts = lib.mkOption {
    default = {};
  };

  config = {
    users.users.nginx.extraGroups = [ "acme" ];

    services.nginx = {
      enable = true;
      recommendedGzipSettings = true;
      recommendedOptimisation = true;
      recommendedProxySettings = true;
      recommendedTlsSettings = true;

      virtualHosts = config.modules.virtualHosts;
    };
  };
}