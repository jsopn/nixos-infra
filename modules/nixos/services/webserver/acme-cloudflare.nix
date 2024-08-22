{ inputs, config, ... }:
{
  age.secrets.acme-cloudflare = {
    file = inputs.self + "/secrets/credentials/cloudflare-acme.age";
    mode = "770";
    owner = "acme";
    group = config.security.acme.defaults.group;
  };

  security.acme = {
    acceptTerms = true;
    defaults = {
      email = "security@jsopn.com";
      dnsProvider = "cloudflare";
      credentialsFile = "${config.age.secrets.acme-cloudflare.path}";
    };
  };
}