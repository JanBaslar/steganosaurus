import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:steganosaurus/global/common/app_bar_icon_button.dart';
import 'package:steganosaurus/global/utils/supported_locales.dart';
import 'package:steganosaurus/modules/hide/view/hide_file_form.dart';
import 'package:steganosaurus/modules/reveal/view/reveal_file_form.dart';

import '../../settings/view/settings_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPageIndex = 0;
  // Field is used for re-rendering if language is changed
  // ignore: unused_field
  Locale _currentLocale = SupportedLocales.english;

  @override
  Widget build(BuildContext context) {
    _currentLocale = context.locale;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Steganosaurus'),
        actions: const <Widget>[
          AppBarIconButton(
              iconData: Icons.settings_rounded, destination: SettingsPage())
        ],
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() => _currentPageIndex = index);
        },
        selectedIndex: _currentPageIndex,
        destinations: <Widget>[
          NavigationDestination(
            icon: const Icon(Icons.image_rounded),
            label: tr('nav.hideFile'),
          ),
          NavigationDestination(
            icon: const Icon(Icons.image_search_rounded),
            label: tr('nav.revealFile'),
          ),
        ],
      ),
      body: const <Widget>[HideFileForm(), RevealFileForm()][_currentPageIndex],
    );
  }
}
