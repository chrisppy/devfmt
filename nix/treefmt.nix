_: {
  perSystem.treefmt = {
    projectRootFile = "flake.nix";
    settings = {
      on-unmatched = "fatal";
      global.excludes = [
        "LICENSE"
        "LICENSE-*"
        # REUSE (https://reuse.software) keeps license texts here.
        "LICENSES/**"
        ".git"
        ".gitattributes"
        ".gitignore"
        "*.jpg"
        "*.patch"
        "*.png"
        "*.svg"
        "**/.gitkeep"
        "**/qmldir"
        "secrets/**"
      ];
    };
  };
}
