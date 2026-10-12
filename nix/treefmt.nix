{ inputs, ... }:
{
  imports = [ inputs.treefmt-nix.flakeModule ];

  perSystem.treefmt = {
    projectRootFile = "flake.nix";
    settings = {
      on-unmatched = "fatal";
      global.excludes = [
        "LICENSE"
        ".git"
        ".gitattributes"
        ".gitignore"
      ];
    };
  };
}
