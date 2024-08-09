{ config, pkgs, homeManagerModules, ... }:
{
  imports = [
    homeManagerModules.apps.firefox
    homeManagerModules.environment.sway
  ];

  wayland.windowManager.sway.config = {
    bars = [
      ({
        mode = "dock";
        position = "top";
        workspaceButtons = true;
        workspaceNumbers = true;
        statusCommand = "${pkgs.i3status}/bin/i3status";
        trayOutput = "primary";
      } // config.lib.stylix.sway.bar)
    ];
  };
}
