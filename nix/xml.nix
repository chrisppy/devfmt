_: {
  perSystem.treefmt = {
    programs.xmllint.enable = true;
    # Apple's property lists (Info.plist, entitlements, privacy manifests) are
    # XML too. Added to the formatter's includes, which merge, rather than set
    # through `programs.xmllint.includes`, which would replace its defaults.
    settings.formatter.xmllint.includes = [
      "*.entitlements"
      "*.plist"
      "*.xcprivacy"
    ];

    # Zola's XML templates (atom.xml, rss.xml, sitemap.xml) are Tera, not XML:
    # xmllint can't parse them and djlint would mangle them, so they are kept
    # as written.
    settings.global.excludes = [
      "templates/*.xml"
      "templates/**/*.xml"
    ];
  };
}
