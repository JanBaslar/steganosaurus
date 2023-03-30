import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:steganosaurus/global/utils/supported_locales.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({super.key});

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  Locale _selected = SupportedLocales.english;

  @override
  void initState() {
    super.initState();
  }

  void setLanguage(Locale locale) {
    setState(() => _selected = locale);
    context.setLocale(locale);
  }

  @override
  Widget build(BuildContext context) {
    _selected = context.locale;
    return Scaffold(
      appBar: AppBar(
        title: const Text('nav.language').tr(),
        actions: const <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: Icon(Icons.language_rounded),
          )
        ],
      ),
      body: Column(
        children: [
          RadioListTile(
            title: const Text('English'),
            value: SupportedLocales.english,
            groupValue: _selected,
            onChanged: (value) => setLanguage(value!),
          ),
          RadioListTile(
            title: const Text('Česky'),
            value: SupportedLocales.czech,
            groupValue: _selected,
            onChanged: (value) => setLanguage(value!),
          ),
        ],
      ),
    );
  }
}
