{ pkgs, ... }:
{
  fonts = {
    fontconfig.enable = true;
    enableDefaultPackages = true;

    fontconfig.defaultFonts = {
      serif = [ "Noto Serif" "Source Han Serif" ];
      sansSerif = [ "Noto Sans" "Source Han Sans" ];
    };

    packages = with pkgs; [
      ibm-plex
      corefonts
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      carlito
      vegur
      source-code-pro
      jetbrains-mono
      font-awesome
      inter
      monaspace

      (nerdfonts.override {
        fonts = [
          "FiraCode"
          "JetBrainsMono"
        ];
      })
    ];
  };
}
