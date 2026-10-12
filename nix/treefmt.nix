_: {
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
