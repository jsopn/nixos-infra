{ config, lib, pkgs, ... }:

let
  cfg = config.modules.hardware.video.nvidia;
in
{
  options.modules.hardware.video.nvidia = {
    enable = lib.mkOption {
      default = false;
    };

    enableOffload = lib.mkOption {
      default = false;
    };

    intelBusId = lib.mkOption {
      default = null;
      example = "PCI:0:2:0";
    };

    nvidiaBusId = lib.mkOption {
      default = null;
      example = "PCI:1:0:0";
    };
  };

  config =
    let
      enablePrime = (cfg.intelBusId != null || cfg.nvidiaBusId != null);
    in
    lib.mkIf cfg.enable {
      hardware.nvidia = {
        modesetting.enable = true;
        nvidiaSettings = true;

        prime = lib.mkIf enablePrime {
          offload = lib.mkIf cfg.enableOffload {
            enable = true;
            enableOffloadCmd = true;
          };

          intelBusId = cfg.intelBusId;
          nvidiaBusId = cfg.nvidiaBusId;
        };
      };

      boot.kernelPackages = pkgs.linuxPackages;

      services.xserver.videoDrivers = [ "nvidia" ];

      # specialisation = {
      #   no-nvidia.configuration = {
      #     environment.etc."specialisation".text = "no-nvidia";

      #     services.xserver.videoDrivers = lib.mkForce [ ];

      #     boot.extraModprobeConfig = ''
      #       blacklist nouveau
      #       options nouveau modeset=0
      #     '';

      #     boot.blacklistedKernelModules = [ "nouveau" "nvidia" "nvidia_drm" "nvidia_modeset" ];
      #   };
      # };
    };
}
