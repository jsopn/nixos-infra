{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.11";
    home-manager = { url = "github:nix-community/home-manager"; inputs.nixpkgs.follows = "nixpkgs"; };

    deploy-rs.url = "github:serokell/deploy-rs";
    nur.url = "github:nix-community/NUR";
    agenix.url = "github:ryantm/agenix";
    stylix.url = "github:danth/stylix";
  };

  outputs = { self, deploy-rs, ... } @ inputs:
    let
      inherit (self) outputs;

      mkLib = import ./lib/flakeMkLib.nix { inherit inputs outputs; };
      modules = import ./modules/default.nix { inherit inputs; };
    in
    {
      nixosConfigurations = (
        mkLib.mkNixOSMachine { hostname = "laptop"; username = "k"; isLaptop = true; } //
        mkLib.mkNixOSMachine { hostname = "alpha"; username = "jsopn"; isServer = true; }
      );

      overlays = import ./overlays { inherit inputs; };
      
      nixosModules = modules.nixos;
      homeManagerModules = modules.hm;

      # -- 

      deploy.nodes.alpha = {
        hostname = "10.100.20.100";
        interactiveSudo = true;

        profiles.system = {
          user = "root";
          sshUser = "jsopn";

          path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.alpha;
          sshOpts = [ "-p" "14228" ];
        };
      };

      # This is highly advised, and will prevent many possible mistakes
      checks = builtins.mapAttrs (system: deployLib: deployLib.deployChecks self.deploy) deploy-rs.lib;
    };
}
