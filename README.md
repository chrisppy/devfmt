# devfmt

One formatting setup for all my repos: a [flake-parts](https://flake.parts)
module built on [treefmt-nix](https://github.com/numtide/treefmt-nix), with
formatters and linters for the languages I use and a strict rule that every file
in a repo is formatted by something or explicitly excluded.

A flake that uses it gets `nix fmt` to format the whole tree, and a `treefmt`
check in `nix flake check` that fails when anything isn't formatted.

## Using it

Add devfmt as an input and build the flake with `devfmt.lib.mkFlake`:

```nix
{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    devfmt = {
      url = "github:chrisppy/devfmt";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs:
    inputs.devfmt.lib.mkFlake { inherit inputs; } {
      imports = [ (inputs.devfmt.lib.importTree ./nix) ];
    };
}
```

Then:

```sh
nix fmt                 # format everything
nix flake check         # includes checks.<system>.treefmt, run on a copy
```

### What it provides

| Output | What it is |
| ------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `lib.mkFlake args module` | flake-parts' `mkFlake` with devfmt included, `systems` from [nix-systems/default](https://github.com/nix-systems/default), and `pkgs` taken from _your_ `nixpkgs` input. `module` can be one module or a list of them. |
| `lib.importTree dir` | [import-tree](https://github.com/denful/import-tree): every `.nix` file under `dir` as a flake-parts module. Files there must be modules; paths containing `/_` (such as `nix/_options.nix`) are skipped, for plain Nix helpers. |
| `flakeModules.default` | The module itself, to add to a flake that already uses flake-parts: `imports = [ inputs.devfmt.flakeModules.default ];`. |
| `formatter.<system>` | devfmt's own treefmt wrapper, for formatting devfmt. |

Flakes using the module get `formatter.<system>` (for `nix fmt`) and
`checks.<system>.treefmt` from treefmt-nix's defaults. Turn either off with
`perSystem.treefmt.flakeFormatter = false` or `flakeCheck = false`.

## Formatters

treefmt runs every formatter that matches a file, in priority order.

| Files | Formatters |
| ---------------------------------- | --------------------------------------------------------------------------------------------- |
| Nix | deadnix, statix, nixf-diagnose, then nixfmt ([nixfmt-rs](https://github.com/Mic92/nixfmt-rs)) |
| Rust | rustfmt |
| C, C++ | clang-format, clang-tidy |
| Go | gofmt, gofumpt, goimports, golangci-lint |
| Shell, fish | shellcheck, fish_indent |
| Swift | swift-format |
| QML | qmlformat |
| TOML | taplo, with aligned entries and sorted keys |
| justfiles | `just --fmt` |
| LaTeX | latexindent, texfmt |
| XML | xmllint |
| Markdown | deno fmt, then mdformat |
| JSON, JSONC, YAML, CSS, SCSS, Sass | deno fmt |
| HTML | djlint (Tera profile), which also lints |

### Every file must match

`on-unmatched` is `fatal`: a file no formatter handles fails `nix fmt` and the
check, so new file types can't slip in unformatted. These are excluded
everywhere:

- `LICENSE`, `LICENSE-*`, and `LICENSES/**` (license texts, which
  [REUSE](https://reuse.software) keeps verbatim)
- `.git`, `.gitattributes`, `.gitignore`, `**/.gitkeep`
- images and fonts: `*.avif`, `*.gif`, `*.ico`, `*.jpeg`, `*.jpg`, `*.png`,
  `*.svg`, `*.webp`, `*.woff`, `*.woff2`
- `*.patch`, `**/qmldir`, `secrets/**`

To exclude more in a project, add to the list (it merges with devfmt's):

```nix
perSystem.treefmt.settings.global.excludes = [ "vendor/**" ];
```

Other treefmt-nix options work the same way, for example
`perSystem.treefmt.programs.<name>.enable` to add a formatter.

## Working on devfmt

```sh
just            # list the recipes
just fmt        # nix fmt
just verify     # check formatting (on a copy), then nix flake check
just update     # nix flake update
```

Flake inputs are updated daily by a workflow. nixfmt-rs follows devfmt's nixpkgs
and treefmt-nix, so flakes using devfmt don't lock a second copy of either.

## License

[MIT](LICENSE).
