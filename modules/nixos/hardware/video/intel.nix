{ config, lib, pkgs, ... }:

let
  cfg = config.modules.hardware.video.intel;
in
{
  options.modules.hardware.video.intel = {
    enable = lib.mkOption {
      default = false;
    };
  };

  config = lib.mkIf cfg.enable {
    hardware.graphics = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver # LIBVA_DRIVER_NAME=iHD
        intel-vaapi-driver # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
        libvdpau-va-gl
        vulkan-validation-layers
      ];
    };

    environment.sessionVariables = { LIBVA_DRIVER_NAME = "iHD"; };

    nixpkgs.config.packageOverrides = pkgs: {
      intel-vaapi-driver = pkgs.intel-vaapi-driver.override { enableHybridCodec = true; };
    };

    hardware.graphics.extraPackages32 = with pkgs.pkgsi686Linux; [ intel-vaapi-driver ];
  };
}
