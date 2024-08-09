{ config, inputs, pkgs, ... }:
{
  imports = [
    inputs.stylix.nixosModules.stylix
  ];

  stylix = {
    enable = true;
    autoEnable = true;

    image = ./assets/wallpaper.jpg;
    polarity = "dark";

    cursor = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
      size = 24;
    };

    fonts = {
      monospace = {
        name = "Terminus";
        package = pkgs.terminus_font;
      };

      serif = config.stylix.fonts.monospace;
      sansSerif = config.stylix.fonts.monospace;
      # emoji = config.stylix.fonts.monospace;
    };

    base16Scheme = "${pkgs.base16-schemes}/share/themes/classic-dark.yaml";
    override = {
      base0D = "#5811ad";
    };
  };
}
