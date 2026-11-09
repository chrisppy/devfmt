_: {
  perSystem.treefmt = {
    # .kt and .kts, which includes Gradle's Kotlin DSL build scripts.
    programs.ktfmt.enable = true;

    # Gradle writes its wrapper (`gradle wrapper`); it is kept as generated.
    settings.global.excludes = [
      "gradlew"
      "gradlew.bat"
      "gradle/wrapper/**"
      "gradle.properties"
    ];
  };
}
