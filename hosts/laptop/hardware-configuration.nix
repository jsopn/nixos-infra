{ ... }:
{
  boot = {
    initrd = {
      availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" ];
      kernelModules = [ "dm-snapshot" ];
    };

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    kernelModules = [ "kvm-intel" "acpi_call" ];
    kernel.sysctl."vm.swappiness" = 10;
    kernelParams = [ "intel_pstate=active" "usbcore.autosuspend=-1" ];

    initrd.luks.devices."encrypted-pv".device = "/dev/disk/by-uuid/8bc93602-968b-4b15-8f91-6d2505bc9238";
  };

  fileSystems = {
    "/" = {
      # encrypted-pv/vg-root
      device = "/dev/disk/by-uuid/b47e1acb-7a96-46d3-b98f-8de4a6cb78f6";
      fsType = "ext4";
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/A05D-BA1E";
      fsType = "vfat";
    };

    "/mnt/games" = {
      device = "/dev/disk/by-uuid/6ebb566e-6906-496b-9a7a-b864623956c6";
      fsType = "ext4";
    };
  };

  swapDevices = [
    # encrypted-pv/vg-swap
    { device = "/dev/disk/by-uuid/9229a970-a560-408a-80ac-c9905e6cfeb1"; }

    {
      device = "/var/lib/swapfile";
      size = 32 * 1024;
    }
  ];

  hardware.cpu.intel.updateMicrocode = true;
}
