{ inputs, config, lib, ... }:
{
  config = {
    age.secrets.fluff-internal-cert = {
      file = inputs.self + "/secrets/certificates/local/fluff.internal/cert.age";
      mode = "770";
      owner = "nginx";
      group = "nginx";
    };

    age.secrets.fluff-internal-key = {
      file = inputs.self + "/secrets/certificates/local/fluff.internal/key.age";
      mode = "770";
      owner = "nginx";
      group = "nginx";
    };

    services.nginx.virtualHosts = builtins.mapAttrs (
      name: 
      value: 
        if lib.strings.hasSuffix "fluff.internal" name then
          value // {
            enableACME = lib.mkForce false;
            forceSSL = true;
            sslCertificate = config.age.secrets.fluff-internal-cert.path;
            sslCertificateKey = config.age.secrets.fluff-internal-key.path;
          }
        else
          value
    ) config.modules.virtualHosts;
  };
}