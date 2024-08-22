{ inputs, ... }:
let
  lib = inputs.nixpkgs.lib;
  
  getModules = 
    path:
      lib.attrsets.concatMapAttrs 
        (k: v: 
          if v == "regular" && lib.strings.hasSuffix ".nix" k then 
            { "${builtins.replaceStrings [".nix"] [""] k}" = import "${path}/${k}"; }
          else
          if v == "directory" then
            { "${k}" = (getModules "${path}/${k}"); }
          else
            {}
        ) 
        (builtins.readDir path);
in
{
  nixos = getModules ./nixos;
  hm = getModules ./hm;
}