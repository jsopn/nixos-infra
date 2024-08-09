{ inputs, outputs }:
{
  mkNixOSMachine =
    { hostname
    , username
    , system ? "x86_64-linux"
    , isServer ? false
    , isDesktop ? false
    , isLaptop ? false
    } @ machineCfg:
    let
      homeManagerImportModule = ({ ... }: {
        home-manager = {
          extraSpecialArgs = {
            inherit inputs outputs system machineCfg;
            inherit (outputs) homeManagerModules;
          };

          users."${username}" = ({ ... }: {
            imports = [
              outputs.homeManagerModules.commons.all
              inputs.nur.nixosModules.nur

              ../hosts/${hostname}/home.nix
            ];
          });
        };
      });
    in
    {
      "${hostname}" = inputs.nixpkgs.lib.nixosSystem
        {
          specialArgs = {
            inherit inputs outputs system machineCfg;
            inherit (outputs) nixosModules;
          };

          modules =
            let
              isWorkstation = isDesktop || isLaptop;
            in
            [
              outputs.nixosModules.commons.all
              inputs.nur.nixosModules.nur

              ../hosts/${hostname}/default.nix
              ../hosts/${hostname}/hardware-configuration.nix
            ]
            ++ (if isWorkstation then [
              outputs.nixosModules.commons.workstation
              outputs.nixosModules.system.home-manager
              homeManagerImportModule
            ] else [ ])
            ++ (if isServer then [ outputs.nixosModules.commons.server ] else [ ])
            ++ (if isLaptop then [ outputs.nixosModules.commons.laptop ] else [ ])
            ++ (if isDesktop then [ outputs.nixosModules.commons.desktop ] else [ ]);
        };
    };

}
