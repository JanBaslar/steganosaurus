import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:steganosaurus/global/config.dart';
import 'package:steganosaurus/global/themes/custom_themes.dart';
import 'package:steganosaurus/global/utils/supported_locales.dart';

import 'modules/home/view/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
      supportedLocales: SupportedLocales.all,
      path: "assets/translations",
      saveLocale: true,
      child: const SteganosaurusApp()));
}

class SteganosaurusApp extends StatefulWidget {
  const SteganosaurusApp({super.key});

  @override
  State<SteganosaurusApp> createState() => _SteganosaurusAppState();
}

class _SteganosaurusAppState extends State<SteganosaurusApp> {
  @override
  void initState() {
    super.initState();
    themeHolder.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: 'Steganosaurus',
      debugShowCheckedModeBanner: false,
      theme: CustomThemes.light,
      darkTheme: CustomThemes.dark,
      themeMode: themeHolder.currentThemeMode(),
      home: const HomePage(),
    );
  }
}
