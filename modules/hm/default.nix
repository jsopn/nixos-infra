{
  commons = {
    all = import ./commons/all.nix;
  };

  apps = {
    firefox = import ./apps/firefox.nix;
  };

  environment = {
    sway = import ./environment/sway.nix;
    hidpiCursor = import ./environment/hidpiCursor.nix;
  };
}
