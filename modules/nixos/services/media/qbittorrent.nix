{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.modules.services.qbittorrent;
  configDir = "${cfg.dataDir}/.config";
  openFilesLimit = 4096;
in
{
  options.modules.services.qbittorrent = {
    dataDir = mkOption {
      type = types.path;
      default = "/var/lib/qbittorrent";
    };

    user = mkOption {
      type = types.str;
      default = "qbittorrent";
    };

    group = mkOption {
      type = types.str;
      default = "qbittorrent";
    };

    domain = mkOption {
      type = types.str;
      default = "qb.fluff.internal";
    };

    webUiPort = mkOption {
      type = types.port;
      default = 51820;
    };

    torrentingPort = mkOption {
      type = types.port;
      default = 51827;
    };

    openFilesLimit = mkOption {
      default = openFilesLimit;
    };
  };

  config = {
    networking.firewall = {
      allowedTCPPorts = [ cfg.torrentingPort ];
      allowedUDPPorts = [ cfg.torrentingPort ];
    };

    systemd.services.qbittorrent = {
      after = [ "network.target" ];
      description = "qBittorrent Daemon";
      wantedBy = [ "multi-user.target" ];
      path = [ pkgs.qbittorrent-nox ];
      serviceConfig = {
        ExecStart = ''
          ${pkgs.qbittorrent-nox}/bin/qbittorrent-nox \
            --profile=${configDir} \
            --webui-port=${toString cfg.webUiPort}
        '';
        Restart = "on-success";
        User = cfg.user;
        Group = cfg.group;
        UMask = "0002";
        LimitNOFILE = cfg.openFilesLimit;
      };

      environment = {
        QBT_WEBUI_PORT = toString cfg.webUiPort;
        QBT_TORRENTING_PORT = toString cfg.torrentingPort;
      };
    };

    users.users = mkIf (cfg.user == "qbittorrent") {
      qbittorrent = {
        isSystemUser = true;
        createHome = true;
        group = cfg.group;
        home = cfg.dataDir;
      };
    };

    users.groups =
      mkIf (cfg.group == "qbittorrent") { qbittorrent = { gid = null; }; };

    modules.virtualHosts."${cfg.domain}" = {
      enableACME = true;
      locations."/".proxyPass = "http://localhost:${toString cfg.webUiPort}";
    };
  };
}