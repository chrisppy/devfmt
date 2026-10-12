{
  description = "My treefmt setup";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    systems.url = "github:nix-systems/default";
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    import-tree.url = "github:denful/import-tree/v0.2.0";
    nixfmt-rs.url = "github:Mic92/nixfmt-rs/0.5.3";
  };

  outputs =
    inputs:
    let
      sharedModule = {
        imports = [
          inputs.treefmt-nix.flakeModule
          (inputs.import-tree ./nix)
        ];

        perSystem =
          { pkgs, ... }:
          {
            treefmt.programs.nixfmt.package =
              inputs.nixfmt-rs.packages.${pkgs.stdenv.hostPlatform.system}.default;
          };
      };
    in
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = import inputs.systems;

      imports = [ sharedModule ];

      flake = {
        flakeModules.default = sharedModule;
        inherit (inputs)
          systems
          flake-parts
          import-tree
          ;
      };

      perSystem =
        { config, ... }:
        {
          formatter = config.treefmt.build.wrapper;
        };
    };
}
