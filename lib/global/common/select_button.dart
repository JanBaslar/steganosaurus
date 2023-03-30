import 'package:flutter/material.dart';
import 'package:steganosaurus/global/utils/styles.dart';

class SelectButton extends StatelessWidget {
  /// Button used for picking files
  const SelectButton(
      {super.key,
      required this.onPressed,
      required this.icon,
      required this.label});

  final void Function() onPressed;
  final Widget icon;
  final Widget label;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: icon,
      label: label,
      style: OutlinedButton.styleFrom(
        side: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: Styles.borderThickness),
      ),
    );
  }
}
