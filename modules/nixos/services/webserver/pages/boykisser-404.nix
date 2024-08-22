{ pkgs, lib, nixosModules, ... }:
let 
  unknown-page = pkgs.writeTextFile {
    name = "boykisser-systems";
    text = (lib.readFile ./pages/404.html);
    destination = "/index.html";
  }; 
in
{
  imports = [ nixosModules.services.webserver.certificates.boykisser-systems ];

  services.nginx.virtualHosts."_" = {
    useACMEHost = "boykisser.systems";
    forceSSL = true;
    root = unknown-page;

    locations = {
      "/".extraConfig = ''
        return 404;
      '';

      "= /index.html".extraConfig = ''
        internal;
      '';
    };

    extraConfig = ''
      error_page 404 /index.html;
    '';
  };
}