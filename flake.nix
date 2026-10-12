{
  description = "My flake setup";
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
    devfmtInputs:
    let
      sharedModule = {
        imports = [
          devfmtInputs.treefmt-nix.flakeModule
          devfmtInputs.flake-parts.flakeModules.modules
          (devfmtInputs.import-tree ./nix)
        ];

        perSystem =
          { pkgs, ... }:
          {
            treefmt.programs.nixfmt.package =
              devfmtInputs.nixfmt-rs.packages.${pkgs.stdenv.hostPlatform.system}.default;
          };
      };

      mkFlake =
        args@{ inputs, ... }:
        userModule:
        devfmtInputs.flake-parts.lib.mkFlake args (
          { ... }:
          {
            systems = import devfmtInputs.systems;

            imports = [
              sharedModule
              (if builtins.isList userModule then { imports = userModule; } else userModule)
            ];

            perSystem =
              { system, ... }:
              {
                _module.args.pkgs = inputs.nixpkgs.legacyPackages.${system};
              };
          }
        );
    in
    devfmtInputs.flake-parts.lib.mkFlake { inputs = devfmtInputs; } {
      systems = import devfmtInputs.systems;

      imports = [ sharedModule ];

      flake = {
        flakeModules.default = sharedModule;

        lib = {
          inherit mkFlake;
          importTree = devfmtInputs.import-tree;
        };
      };

      perSystem =
        { config, ... }:
        {
          formatter = config.treefmt.build.wrapper;
        };
    };
}
