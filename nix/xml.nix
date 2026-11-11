_: {
  perSystem.treefmt = {
    programs.xmllint.enable = true;
    # Apple's property lists (Info.plist, entitlements) are XML too. Added to
    # the formatter's includes, which merge, rather than set through
    # `programs.xmllint.includes`, which would replace its defaults.
    settings.formatter.xmllint.includes = [
      "*.entitlements"
      "*.plist"
    ];
  };
}
