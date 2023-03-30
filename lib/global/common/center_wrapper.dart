import 'package:flutter/material.dart';
import 'package:steganosaurus/global/utils/styles.dart';

class CenterWrapper extends StatelessWidget {
  /// Wrapes the screen layout, centers content in column and adds margin.
  const CenterWrapper(this.children, {super.key});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.all(Styles.allMargin),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: children,
      ),
    );
  }
}
