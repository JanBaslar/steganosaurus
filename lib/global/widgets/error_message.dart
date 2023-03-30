import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../utils/styles.dart';

class ErrorMessage extends StatelessWidget {
  const ErrorMessage(this.message, {super.key});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.errorContainer,
        borderRadius: const BorderRadius.all(
          Radius.circular(Styles.borderRadius),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Icon(Icons.error_rounded,
                color: Theme.of(context).colorScheme.error),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: Text(
                  message,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ).tr(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
