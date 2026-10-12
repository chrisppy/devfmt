{ inputs, ... }:
{
  perSystem.treefmt =
    { pkgs, ... }:
    {
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
          package = inputs.nixfmt-rs.packages.${pkgs.stdenv.hostPlatform.system}.default;
          priority = 4;
        };
      };
    };
}
