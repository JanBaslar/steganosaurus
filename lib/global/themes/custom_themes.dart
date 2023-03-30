import 'package:flutter/material.dart';
import 'package:steganosaurus/global/utils/styles.dart';

/// Defines all themes used in app.
class CustomThemes {
  /// Dark Material 3 theme
  static ThemeData dark = ThemeData(
      colorSchemeSeed: Styles.seedColor,
      brightness: Brightness.dark,
      useMaterial3: true);

  /// Light Material 3 theme
  static ThemeData light = ThemeData(
      colorSchemeSeed: Styles.seedColor,
      brightness: Brightness.light,
      useMaterial3: true);
}
