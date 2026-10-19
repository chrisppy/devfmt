_: {
  perSystem.treefmt = {
    projectRootFile = "flake.nix";
    settings = {
      on-unmatched = "fatal";
      global.excludes = [
        "LICENSE"
        "LICENSE-*"
        "qmldir"
        ".git"
        ".gitattributes"
        ".gitignore"
        "*.jpg"
        "*.patch"
        "*.png"
        "*.svg"
        "**/.gitkeep"
        "secrets/**"
      ];
    };
  };
}
