import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:steganosaurus/global/utils/theme_keys.dart';

/// Holds and change current theme and saves it to local storage.
class ThemeHolder with ChangeNotifier {
  /// Holds current theme mode.
  ThemeMode _currentThemeMode = ThemeMode.system;

  /// Checks if theme was already loaded from locale storage.
  bool _wasLoaded = false;

  /// Key in local storage.
  final _key = 'currentTheme';

  /// Loads theme in constructor.
  ThemeHolder() {
    loadTheme();
  }

  /// Loads theme from locale storage.
  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(_key)) {
      String savedTheme = prefs.getString(_key)!;
      switch (savedTheme) {
        case ThemeKeys.dark:
          _currentThemeMode = ThemeMode.dark;
          break;
        case ThemeKeys.light:
          _currentThemeMode = ThemeMode.light;
          break;
        default:
          _currentThemeMode = ThemeMode.system;
          break;
      }
    } else {
      prefs.setString(_key, ThemeKeys.system);
    }
    _wasLoaded = true;
  }

  /// Gets current theme.
  ThemeMode currentThemeMode() {
    if (!_wasLoaded) {
      loadTheme().then((_) => notifyListeners());
    }
    return _currentThemeMode;
  }

  /// Change current theme.
  Future<void> changeMode(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    _currentThemeMode = mode;
    switch (mode) {
      case ThemeMode.dark:
        prefs.setString(_key, ThemeKeys.dark);
        break;
      case ThemeMode.light:
        prefs.setString(_key, ThemeKeys.light);
        break;
      default:
        prefs.setString(_key, ThemeKeys.system);
        break;
    }
    notifyListeners();
  }
}
