{ config, pkgs, lib, ... }:
let 
  cfg = config.modules.services.jellyfin;
in 
{
  options.modules.services.jellyfin = {
    domain = lib.mkOption {
      type = lib.types.str;
      default = "jf.fluff.internal";
    };
  };

  config = {
    environment.systemPackages = [
      pkgs.jellyfin
      pkgs.jellyfin-web
      pkgs.jellyfin-ffmpeg
    ];

    services.jellyfin = {
      enable = true;
      openFirewall = true;
    };

    modules.virtualHosts."${cfg.domain}" = {
      enableACME = true;

      locations."/".proxyPass = "http://localhost:8096";
      locations."/socket" = {
        proxyPass = "http://localhost:8096";
        proxyWebsockets = true;
      };
    };
  };
}