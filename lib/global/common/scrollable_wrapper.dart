import 'package:flutter/material.dart';
import 'package:steganosaurus/global/utils/styles.dart';

class ScrollableWrapper extends StatelessWidget {
  /// Wrapes the screen layout into scrollable column and adds margin.
  const ScrollableWrapper(this.children, {super.key});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(Styles.allMargin),
        child: Column(children: children),
      ),
    );
  }
}
