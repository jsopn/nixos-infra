{ lib, machineCfg, ... }:
let
  jsopnDefaults = {
    extraGroups = [ "wheel" "video" "docker" ];

    openssh.authorizedKeys.keys = [
      (lib.readFile ./keys/jsopn-master-ed25519.pub)
    ];
  };

  predefinedUserDefaults = {
    "k" = jsopnDefaults;
    "jsopn" = jsopnDefaults;
  };
in
{
  users.users.${machineCfg.username} = {
    isNormalUser = true;
  } // predefinedUserDefaults.${machineCfg.username};
}
