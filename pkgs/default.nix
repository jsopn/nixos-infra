pkgs: {
  vesktopOverlayGtk = pkgs.symlinkJoin {
    name = "vesktopOverlay";
    paths = [ pkgs.vesktop ];
    buildInputs = [ pkgs.makeWrapper pkgs.nvidia-vaapi-driver pkgs.libva-utils pkgs.libva ];
    postBuild = ''
      wrapProgram $out/bin/vesktop \
        --append-flags "--enable-webrtc-pipewire-capturer" \
        --append-flags "--ozone-platform-hint=auto" \
        --append-flags "--enable-features=WaylandWindowDecorations" \
        --set GTK_USE_PORTAL 1
    '';
  };
}
