_: {
  perSystem.treefmt = {
    settings.formatter.taplo.options = [
      "fmt"
      "-o"
      "align_entries=true"
      "-o"
      "reorder_keys=true"
    ];

    programs.taplo.enable = true;
  };
}
