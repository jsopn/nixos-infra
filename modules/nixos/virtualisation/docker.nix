{ machineCfg, ... }:
{
  virtualisation = {
    containers.enable = true;

    docker = {
      enable = true;
      autoPrune.enable = true;
      daemon.settings.dns = [ "1.1.1.1" "1.0.0.1" ];
    };

    oci-containers.backend = "docker";
  };

  users.users.${machineCfg.username}.extraGroups = [ "docker" ];
}
