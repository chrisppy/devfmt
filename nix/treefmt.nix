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
        # Images and other binary assets.
        "*.avif"
        "*.desktop"
        "*.gif"
        "*.ico"
        "*.jpeg"
        "*.jpg"
        "*.png"
        "*.svg"
        "*.webp"
        "*.woff"
        "*.woff2"
        "*.patch"
        "**/.gitkeep"
        "**/qmldir"
        "secrets/**"
      ];
    };
  };
}
