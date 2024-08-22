{ ... }:
{
  security.acme.certs."jsopn.com" = {
    email = "cert+admin@jsopn.com";
    extraDomainNames = [ 
      "jsop.ru"
      "evgn.dev"
      "jsopn.xyz"
      "evgeniy.xyz"
      "jsopdomain.com"
      "jsopn.ru"

      "*.jsopn.com"
      "*.jsop.ru"
      "*.evgn.dev"
      "*.jsopn.xyz"
      "*.evgeniy.xyz"
      "*.jsopdomain.com"
      "*.jsopn.ru"
    ];
  };
}