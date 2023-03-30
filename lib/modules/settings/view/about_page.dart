import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('nav.about').tr(),
        actions: const <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: Icon(Icons.info_rounded),
          )
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        child: const Text('nav.about').tr(),
      ),
    );
  }
}
