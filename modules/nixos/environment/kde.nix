{ lib, ... }:
{
  services = {
    xserver = {
      enable = true;
      dpi = 96;
    };

    desktopManager.plasma6.enable = true;
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };

    tlp.enable = lib.mkForce false;
  };
}
