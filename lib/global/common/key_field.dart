import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/styles.dart';

class KeyField extends StatefulWidget {
  const KeyField({
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
  State<KeyField> createState() => _KeyFieldState();
}

class _KeyFieldState extends State<KeyField> {
  bool _obscure = true;
  Icon _icon = const Icon(Icons.visibility_off_rounded);

  @override
  Widget build(BuildContext context) {
    return TextField(
      restorationId: 'key_field',
      textCapitalization: TextCapitalization.words,
      inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'\s'))],
      obscureText: _obscure,
      decoration: InputDecoration(
          filled: true,
          prefixIcon: widget.icon,
          isDense: true,
          border: const OutlineInputBorder(
            borderSide: BorderSide(width: Styles.borderThickness),
            borderRadius: BorderRadius.all(
              Radius.circular(Styles.borderRadius),
            ),
          ),
          hintText: widget.hintText,
          labelText: widget.label,
          suffixIcon: IconButton(
            icon: _icon,
            onPressed: () {
              setState(() {
                if (_obscure) {
                  _icon = const Icon(Icons.visibility_rounded);
                } else {
                  _icon = const Icon(Icons.visibility_off_rounded);
                }
                _obscure = !_obscure;
              });
            },
          )),
      onChanged: widget.onChange,
      controller: widget.controller,
    );
  }
}
