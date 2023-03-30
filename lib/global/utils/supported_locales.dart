import 'dart:ui';

/// Defines all supported languages in app.
class SupportedLocales {
  static const Locale english = Locale("en", "US");
  static const Locale czech = Locale("cs", "CS");

  static const List<Locale> all = <Locale>[
    english,
    czech,
  ];
}
