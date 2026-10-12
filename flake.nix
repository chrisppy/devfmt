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
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        (inputs.import-tree ./nix)
      ];
      flake.flakeModules.default = {
        imports = [
          inputs.treefmt-nix.flakeModule
          (inputs.import-tree ./nix)
        ];
      };
      perSystem =
        { config, ... }:
        {
          formatter = config.treefmt.build.wrapper;
        };
    };
}
