import 'package:flutter/material.dart';
import 'package:steganosaurus/global/utils/styles.dart';

class ConfirmButton extends StatelessWidget {
  /// Biggest button used for main actions
  const ConfirmButton({super.key, required this.label, this.onPressed});

  final String label;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(50),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: Styles.importantTextSize),
      ),
    );
  }
}
