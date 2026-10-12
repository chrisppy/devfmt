_: {
  perSystem.treefmt = {
    settings.formatter.djlint.options = [
      "--profile=tera"
    ];

    programs = {
      deno = {
        enable = true;
        includes = [
          "*.markdown"
          "*.md"
          "*.scss"
        ];
      };
      djlint = {
        enable = true;
        includes = [
          "*.html"
        ];
        lint = true;
      };
      mdformat.enable = true;
    };
  };
}
