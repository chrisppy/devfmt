{
  description = "My treefmt setup";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    import-tree.url = "github:vic/import-tree";
    nixfmt-rs.url = "github:Mic92/nixfmt-rs/0.5.3";
  };

  outputs =
    inputs:
    let
      # Shared module configuration defined once
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
      # 1. Use the shared module locally in devfmt
      imports = [ sharedModule ];

      # 2. Export the exact same module for external projects
      flake.flakeModules.default = sharedModule;

      # 3. Expose the formatter wrapper locally
      perSystem =
        { config, ... }:
        {
          formatter = config.treefmt.build.wrapper;
        };
    };
}
