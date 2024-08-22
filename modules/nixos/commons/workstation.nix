{ ... }:
{
  imports = [
    ../system/ssh.nix
    ../hardware/yubikey.nix

    ../environment/fonts.nix
  ];

  security.polkit.enable = true;
  services.automatic-timezoned.enable = true;
  boot.supportedFilesystems = [ "ntfs" ];
}
