{ ... }:
{
  services = {
    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
      };
      ports = [ 14228 ];
    };
  };

  networking.firewall = {
    allowedTCPPorts = [ 14228 ];
  };
}
