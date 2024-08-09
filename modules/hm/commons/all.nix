{ lib, pkgs, machineCfg, ... }:
{
  imports = [
    ../shell/bash.nix
    ../shell/ranger.nix
  ];

  home = {
    username = lib.mkDefault "${machineCfg.username}";
    homeDirectory = lib.mkDefault "/home/${machineCfg.username}";
    stateVersion = lib.mkDefault "23.11";

    packages = with pkgs; [
      bottles
      gparted
      qbittorrent
      keepassxc

      devenv

      vesktopOverlayGtk
      telegram-desktop
      thunderbird

      obsidian
      nix-ld

      vscode
      nh

      gcc
      libnotify
      freerdp

      htop
      pfetch

      ffmpeg

      nixpkgs-fmt
      nixd

      tor-browser
      scrcpy

      dua
    ];
  };

  services.flameshot.enable = true;
  programs = {
    mpv.enable = true;
    obs-studio.enable = true;
    yt-dlp.enable = true;

    git = {
      enable = true;
      lfs.enable = true;

      userName = "jsopn";
      userEmail = "me@jsopn.com";

      aliases = {
        ci = "commit";
        co = "checkout";
        s = "status";
      };

      extraConfig = {
        credential.helper = "${
          pkgs.git.override { withLibsecret = true; }
        }/bin/git-credential-libsecret";
      };
    };

    home-manager.enable = true;
  };

  systemd.user.startServices = "sd-switch";
}
