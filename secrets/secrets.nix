let
  jsopn-master = "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAiKGH29YxTppEfNq5ZKNwc3v+gIqIBFd3SVvw4/lS/7sZxGulwb2bES2Mml4LHS3wteGYjhq74AKWX9SDoYWKdBFfa3NCNw9G56IXzVnVc+e8Ta0Bwg1z1hR4ntRlNLhVe4BGA6hrZACekfoF0xOaJlle1Fczm5nklT5nkt8P/CIqAitoN6zys2RPiFlZRoF423b2s4QMogARhd+t7qX7Ztv12uraS0Cxu21YXFEoyncsT0IgYhDbmS0pGCcAam66bZk3VEwSYYt8F0UYMMVafPp2Jg5dLocpEAJTolH/g5b4BQnwq2IRafgBAdDSZysrPq7Y5XUQEYaw+NrjH4HTLQ==";
  users = [ jsopn-master ];
  
  alpha = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEHTMpuuCVOSjV0FOUYJpM0k4Rob4GVLjp4DJ0KXTrO/ root@alpha";
  hosts = [ alpha ];
in
{
  "credentials/cloudflare-acme.age".publicKeys = users ++ hosts;

  "certificates/local/fluff.internal/cert.age".publicKeys = users ++ [ alpha ];
  "certificates/local/fluff.internal/key.age".publicKeys = users ++ [ alpha ];
}
