{ config, lib, machineCfg, ... }:

let
  cfg = config.modules.services.files.syncthing;
in
{
  options.modules.services.files.syncthing = {
    openFirewall = lib.mkOption {
      default = false;
      example = true;
    };

    user = lib.mkOption {
      default = "${machineCfg.username}";
      example = "";
    };

    group = lib.mkOption {
      default = "users";
      example = "";
    };

    configDir = lib.mkOption {
      default = "/home/${machineCfg.username}/.sync/.config";
      example = "";
    };
  };

  config = {
    services.syncthing = {
      enable = true;

      user = cfg.user;
      group = cfg.group;

      configDir = cfg.configDir;

      overrideDevices = false;
      overrideFolders = false;
    };

    networking.firewall.allowedTCPPorts = if cfg.openFirewall then [ 22000 ] else [ ];
    networking.firewall.allowedUDPPorts = if cfg.openFirewall then [ 22000 21027 ] else [ ];
  };
}
