import 'package:flutter/material.dart';

class ListTileNavigator extends StatelessWidget {
  /// Tile used for navigation in settings menu
  const ListTileNavigator({
    super.key,
    required this.title,
    required this.destination,
    this.leadingIcon,
    this.subtitle,
  });

  final Text title;
  final Widget destination;
  final Icon? leadingIcon;
  final Text? subtitle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leadingIcon,
      title: title,
      subtitle: subtitle,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destination),
        );
      },
    );
  }
}
