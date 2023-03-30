import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:steganosaurus/global/config.dart';

class ThemePage extends StatefulWidget {
  const ThemePage({super.key});

  @override
  State<ThemePage> createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {
  ThemeMode _selected = themeHolder.currentThemeMode();

  @override
  void initState() {
    super.initState();
  }

  void setTheme(ThemeMode themeMode) {
    setState(() => _selected = themeMode);
    themeHolder.changeMode(themeMode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('nav.theme').tr(),
        actions: const <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: Icon(Icons.brightness_6_rounded),
          )
        ],
      ),
      body: Column(
        children: [
          RadioListTile(
            title: const Text('thm.system').tr(),
            subtitle: const Text('cap.system').tr(),
            value: ThemeMode.system,
            groupValue: _selected,
            onChanged: (value) => setTheme(value!),
          ),
          RadioListTile(
            title: const Text('thm.dark').tr(),
            value: ThemeMode.dark,
            groupValue: _selected,
            onChanged: (value) => setTheme(value!),
          ),
          RadioListTile(
            title: const Text('thm.light').tr(),
            value: ThemeMode.light,
            groupValue: _selected,
            onChanged: (value) => setTheme(value!),
          ),
        ],
      ),
    );
  }
}
