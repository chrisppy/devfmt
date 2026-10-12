_: {
  perSystem.treefmt = {
    programs = {
      deadnix = {
        enable = true;
        priority = 1;
      };
      statix = {
        enable = true;
        priority = 2;
      };
      nixf-diagnose = {
        enable = true;
        priority = 3;
      };
      nixfmt = {
        enable = true;
        priority = 4;
      };
    };
  };
}
