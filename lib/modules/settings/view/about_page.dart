import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:steganosaurus/global/common/column_spacer.dart';
import 'package:steganosaurus/global/common/scrollable_wrapper.dart';
import 'package:steganosaurus/global/utils/styles.dart';

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
        body: ScrollableWrapper([
          const Text('inf.part1').tr(),
          const ColumnSpacer(Styles.smallGap),
          Image.asset(Theme.of(context).brightness == Brightness.dark
              ? 'assets/images/schemaDark.png'
              : 'assets/images/schemaLight.png'),
          const ColumnSpacer(Styles.smallGap),
          const Text('inf.part2').tr(),
        ]));
  }
}
