{ machineCfg, pkgs, ... }:
{
  boot.kernelModules = [ "vfio" "vfio_iommu_type1" "vfio_pci" "vfio_virqfd" ];
  boot.kernelParams = [ "intel_iommu=on" "iommu=pt" ];

  programs.virt-manager.enable = true;
  systemd.tmpfiles.rules = [
    "f	/dev/shm/looking-glass	0660	${machineCfg.username}	kvm	-"
  ];

  environment.systemPackages = [ pkgs.dmidecode ];

  virtualisation.libvirtd = {
    enable = true;

    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
      ovmf = {
        enable = true;
        packages = [
          (pkgs.OVMF.override {
            secureBoot = true;
            tpmSupport = true;
          }).fd
        ];
      };
    };
  };

  users.users."${machineCfg.username}" = {
    extraGroups = [ "libvirtd" ];
  };
}
