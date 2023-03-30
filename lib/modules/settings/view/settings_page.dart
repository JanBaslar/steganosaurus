import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:steganosaurus/global/common/list_tile_navigator.dart';
import 'package:steganosaurus/modules/settings/view/about_page.dart';
import 'package:steganosaurus/modules/settings/view/language_page.dart';
import 'package:steganosaurus/modules/settings/view/theme_page.dart';

import '../../../global/utils/supported_locales.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // Field is used for re-rendering if language is changed
  // ignore: unused_field
  Locale _currentLocale = SupportedLocales.english;

  @override
  Widget build(BuildContext context) {
    _currentLocale = context.locale;
    return Scaffold(
      appBar: AppBar(
        title: const Text('nav.settings').tr(),
        actions: const <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: Icon(Icons.settings_rounded),
          )
        ],
      ),
      body: ListView(
        children: [
          ListTileNavigator(
              leadingIcon: const Icon(Icons.language_rounded),
              subtitle: const Text('cap.language').tr(),
              title: const Text('nav.language').tr(),
              destination: const LanguagePage()),
          ListTileNavigator(
              leadingIcon: const Icon(Icons.brightness_6_rounded),
              subtitle: const Text('cap.theme').tr(),
              title: const Text('nav.theme').tr(),
              destination: const ThemePage()),
          ListTileNavigator(
              leadingIcon: const Icon(Icons.info_rounded),
              subtitle: const Text('cap.about').tr(),
              title: const Text('nav.about').tr(),
              destination: const AboutPage()),
        ],
      ),
    );
  }
}
