{
  commons = {
    all = import ./commons/all.nix;
    workstation = import ./commons/workstation.nix;
    server = import ./commons/server.nix;
    laptop = import ./commons/laptop.nix;
    desktop = import ./commons/desktop.nix;
  };

  system = {
    home-manager = import ./system/home-manager.nix;
    audio.pipewire = import ./system/audio/pipewire.nix;

    boot = {
      plymouth = import ./system/boot/plymouth.nix;
    };
  };

  hardware = {
    ssd = import ./hardware/ssd.nix;
    video = import ./hardware/video;
    bluetooth = import ./hardware/bluetooth.nix;
    yubikey = import ./hardware/yubikey.nix;
    opentabletdriver = import ./hardware/opentabletdriver.nix;
    flipperzero = import ./hardware/flipperzero.nix;
  };

  networking = {
    avahiDiscovery = import ./networking/avahiDiscovery.nix;
  };

  games = {
    steam = import ./games/steam.nix;
  };

  environment = {
    fonts = import ./environment/fonts.nix;
    kde = import ./environment/kde.nix;
    sway = import ./environment/sway.nix;
  };

  services = {
    files.syncthing = import ./services/files/syncthing.nix;
  };

  virtualisation = {
    docker = import ./virtualisation/docker.nix;
  };
}
