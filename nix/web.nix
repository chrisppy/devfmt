_: {
  perSystem.treefmt = {
    settings.formatter.djlint.options = [
      "--profile=tera"
    ];

    programs = {
      deno = {
        enable = true;
        includes = [
          "*.css"
          "*.json"
          "*.jsonc"
          "*.markdown"
          "*.md"
          "*.sass"
          "*.scss"
          "*.yaml"
          "*.yml"
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
