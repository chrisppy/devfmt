# Changelog

All notable changes to devfmt are recorded here. The format is based on
[Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

There are no tagged releases yet, so changes are grouped by date under
Unreleased. Routine flake input updates are left out.

## Unreleased

### 2026-11-12

#### Changed

- Web app manifests (`*.webmanifest`) and static-host routing files
  (`_redirects`, `_headers`) are skipped. They used to fail `nix fmt` with "no
  formatter for path".

### 2026-11-11

#### Added

- Apple property lists (`*.plist`, `*.entitlements`) are formatted with xmllint.
  A macOS entitlements file used to fail `nix fmt` with "no formatter for path".

### 2026-11-09

#### Added

- Kotlin (`.kt` and `.kts`, including Gradle build scripts) is formatted with
  ktfmt. The Gradle wrapper (`gradlew`, `gradlew.bat`, `gradle/wrapper/**`) and
  `gradle.properties` are excluded.

### 2026-11-07

#### Added

- Swift is formatted with swift-format.
- More binary assets are excluded from formatting: `*.avif`, `*.gif`, `*.ico`,
  `*.jpeg`, `*.webp`, `*.woff` and `*.woff2`. A WebP image used to fail
  `nix fmt` with "no formatter for path".
- `LICENSES/**` is excluded, so REUSE license texts stay verbatim.
- justfile with `check`, `fmt`, `fmt-check`, `show`, `update`, `update-input`
  and `verify` recipes.
- README.

### 2026-11-01

#### Fixed

- nixfmt-rs follows devfmt's nixpkgs and treefmt-nix, so flakes using devfmt
  lock one nixpkgs instead of three and don't build a second Rust toolchain.

### 2026-10-17 to 2026-10-19

#### Added

- `**/qmldir` is excluded from formatting.
- Flake inputs are updated by a scheduled workflow.

### 2026-10-12

- Initial release: a flake-parts module on treefmt-nix with formatters and
  linters for each language, a fatal `on-unmatched` rule, deno for web formats,
  `LICENSE-*` and other common excludes, and re-exported inputs.
