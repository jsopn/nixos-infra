{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.11";
    home-manager = { url = "github:nix-community/home-manager"; inputs.nixpkgs.follows = "nixpkgs"; };

    nur.url = "github:nix-community/NUR";
    agenix.url = "github:ryantm/agenix";
    stylix.url = "github:danth/stylix";
  };

  outputs = { self, ... } @ inputs:
    let
      inherit (self) outputs;

      mkLib = import ./lib/flakeMkLib.nix { inherit inputs outputs; };
    in
    {
      nixosConfigurations = (
        mkLib.mkNixOSMachine { hostname = "laptop"; username = "k"; isLaptop = true; }
      );

      overlays = import ./overlays { inherit inputs; };
      nixosModules = import ./modules/nixos;
      homeManagerModules = import ./modules/hm;
    };
}
