import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/styles.dart';

class StegField extends StatelessWidget {
  /// Custom TextField with for keys;
  const StegField({
    super.key,
    required this.icon,
    required this.onChange,
    required this.label,
    this.hintText,
    required this.controller,
  });

  final Icon icon;
  final void Function(String) onChange;
  final String label;
  final TextEditingController controller;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      restorationId: 'key_field',
      textCapitalization: TextCapitalization.words,
      inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'\s'))],
      decoration: InputDecoration(
        filled: true,
        prefixIcon: icon,
        isDense: true,
        border: const OutlineInputBorder(
          borderSide: BorderSide(width: Styles.borderThickness),
          borderRadius: BorderRadius.all(
            Radius.circular(Styles.borderRadius),
          ),
        ),
        hintText: hintText,
        labelText: label,
      ),
      onChanged: onChange,
      controller: controller,
    );
  }
}
