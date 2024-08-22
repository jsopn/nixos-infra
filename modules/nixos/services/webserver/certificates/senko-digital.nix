{ ... }:
{
  security.acme.certs."senko.digital" = {
    email = "cert+admin@snk.wtf";
    extraDomainNames = [ 
      "snk.wtf"
      
      "*.senko.digital"
      "*.snk.wtf"
    ];
  };
}