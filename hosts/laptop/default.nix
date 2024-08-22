{ nixosModules, ... }:
{
  imports = with nixosModules; [
    system.audio.pipewire
    system.boot.plymouth

    hardware.ssd
    hardware.video
    hardware.bluetooth
    hardware.flipperzero

    networking.avahiDiscovery

    games.steam

    services.files.syncthing

    environment.sway

    virtualisation.docker
    virtualisation.libvirt
  ] ++ [
    ./stylix.nix
  ];

  modules = {
    hardware.video = {
      intel.enable = true;

      nvidia = {
        enable = true;

        enableOffload = true;
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };
  };

  # sway fix
  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
  };

  time.timeZone = "Asia/Tbilisi";
}
