{ ... }:
{
  boot = {
    initrd = {
      availableKernelModules = [ "ata_piix" "uhci_hcd" "virtio_pci" "virtio_scsi" "sd_mod" "sr_mod" ];
      kernelModules = [ ];
    };

    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [ ];

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/7b668b78-46ed-44b1-9e92-c5a35cdd6009";
      fsType = "ext4";
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/64E8-B251";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };

    "/mnt/media" = {
      device = "10.100.20.13:/mnt/pool1/media";
      fsType = "nfs";
    };
  };

  networking = {
    defaultGateway = "10.100.20.1";    
    hostName = "alpha";

    firewall.allowedTCPPorts = [ 80 443 ];
  };
}
