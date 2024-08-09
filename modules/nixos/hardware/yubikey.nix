{ pkgs, ... }:
{
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services.udev.packages = [ pkgs.yubikey-personalization ];

}
