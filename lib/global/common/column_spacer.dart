import 'package:flutter/material.dart';

class ColumnSpacer extends StatelessWidget {
  /// Adds extra space bettween column elements.
  const ColumnSpacer(this.space, {super.key});

  final double space;

  @override
  Widget build(BuildContext context) {
    return Container(height: space);
  }
}
