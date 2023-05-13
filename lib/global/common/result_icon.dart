import 'package:flutter/material.dart';

class ResultIcon extends StatelessWidget {
  const ResultIcon(this.success, {super.key});

  final bool success;

  @override
  Widget build(BuildContext context) {
    IconData data = Icons.cancel_rounded;
    Color color = Theme.of(context).colorScheme.error;
    if (success) {
      data = Icons.check_circle_rounded;
      color = Theme.of(context).colorScheme.primary;
    }

    return Icon(data, color: color, size: 80);
  }
}
