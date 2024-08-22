{ lib, inputs, outputs, system, machineCfg, pkgs, ... }:
{
  imports = [
    ../system/users

    inputs.agenix.nixosModules.default
  ];

  environment.systemPackages = (with pkgs; [
    gnugrep
    gawk
    rar
    zip
    unzip
    unrar
    p7zip
    coreutils-full
    pciutils
    util-linux
    python3
    virtualenv
  ]) ++ [
    inputs.agenix.packages."${system}".default
  ];

  services.fwupd.enable = true;
  hardware.enableRedistributableFirmware = true;

  nixpkgs = {
    hostPlatform = {
      inherit system;
    };

    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.stable-packages
    ];

    config.allowUnfree = true;
  };

  system.stateVersion = lib.mkDefault "23.11";

  nix = {
    settings = {
      auto-optimise-store = true;
      trusted-users = [ "@wheel" ];
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 2d";
    };

    extraOptions = "experimental-features = nix-command flakes";
  };

  networking = {
    hostName = lib.mkDefault machineCfg.hostname;
    networkmanager.enable = true;
    firewall.enable = true;
  };
}
