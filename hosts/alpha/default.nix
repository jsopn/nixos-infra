{ nixosModules, ... }:
{
  imports = with nixosModules; [
    networking.avahiDiscovery

    services.webserver.certificates.fluff-internal
    services.webserver.nginx
    
    services.media.jellyfin
    services.media.qbittorrent
  ];

  modules.services = {
    jellyfin.domain = "jf.fluff.internal";
    qbittorrent.domain = "qb.fluff.internal";
  };
}