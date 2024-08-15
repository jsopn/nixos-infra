{ nixosModules, ... }:
{
  imports = [
    nixosModules.system.audio.pipewire
    nixosModules.system.boot.plymouth

    nixosModules.hardware.ssd
    nixosModules.hardware.video
    nixosModules.hardware.bluetooth

    nixosModules.networking.avahiDiscovery

    nixosModules.games.steam

    nixosModules.services.files.syncthing

    nixosModules.environment.sway

    nixosModules.virtualisation.docker

    ./stylix.nix
  ];

  modules = {
    hardware.video = {
      intel.enable = true;

      nvidia = {
        enable = true;
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };
  };

  # sway fix
  environment.sessionVariables = {
    WLR_DRM_DEVICES = "/dev/dri/card1";
    WLR_DRM_NO_MODIFIERS = "1";
  };
}
