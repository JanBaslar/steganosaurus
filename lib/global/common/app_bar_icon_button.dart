import 'package:flutter/material.dart';

class AppBarIconButton extends StatelessWidget {
  const AppBarIconButton(
      {super.key, required this.iconData, required this.destination});

  final IconData iconData;
  final Widget destination;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
          shape: const CircleBorder()),
      child: Icon(
        iconData,
        color: Theme.of(context).colorScheme.secondary,
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destination),
        );
      },
    );
  }
}
