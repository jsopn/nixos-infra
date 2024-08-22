{ inputs, ... }: {
  additions = final: _prev: import ../pkgs final.pkgs;

  modifications = final: prev: {
    sway-unwrapped = prev.sway-unwrapped.overrideAttrs (attrs: {
      version = "0-unstable-2024-08-11";
      src = final.fetchFromGitHub {
        owner = "swaywm";
        repo = "sway";
        rev = "b44015578a3d53cdd9436850202d4405696c1f52";
        hash = "sha256-gTsZWtvyEMMgR4vj7Ef+nb+wcXkwGivGfnhnBIfPHOA=";
      };
      buildInputs = attrs.buildInputs ++ [ final.wlroots ];
      mesonFlags =
        let
          inherit (final.lib.strings) mesonEnable mesonOption;
        in
        [
          (mesonOption "sd-bus-provider" "libsystemd")
          (mesonEnable "tray" attrs.trayEnabled)
        ];
    });

    wlroots = prev.wlroots.overrideAttrs (_attrs: {
      version = "0-unstable-2024-08-11";
      src = final.fetchFromGitLab {
        domain = "gitlab.freedesktop.org";
        owner = "wlroots";
        repo = "wlroots";
        rev = "6214144735b6b85fa1e191be3afe33d6bea0faee";
        hash = "sha256-nuG2xXLDFsGh23CnhaTtdOshCBN/yILqKCSmqJ53vgI=";
      };
    });
  };

  stable-packages = final: _prev: {
    stable = import inputs.nixpkgs-stable {
      system = final.system;
      config.allowUnfree = true;
    };
  };
}
