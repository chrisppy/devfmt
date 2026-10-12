_: {
  perSystem.treefmt = {
    projectRootFile = "flake.nix";
    settings = {
      on-unmatched = "fatal";
      global.excludes = [
        "LICENSE"
        "LICENSE-*"
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
