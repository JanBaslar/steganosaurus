import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:steganosaurus/global/utils/styles.dart';

class ImagePreview extends StatelessWidget {
  /// Widget for picking Images with image preview.
  const ImagePreview(this.imgPath, {super.key});

  final String? imgPath;

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width * 0.5;

    Container imageNotFound = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.tertiaryContainer,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.image_not_supported_rounded,
            color: Theme.of(context).colorScheme.tertiary,
            size: size / 4,
          ),
          const Text("err.imgNotFound").tr()
        ],
      ),
    );

    ClipRRect showImage(String path) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(Styles.borderRadius),
        child: SizedBox.fromSize(
          child: Image.file(
            File(path),
            height: size,
            errorBuilder: (context, error, stackTrace) => imageNotFound,
          ),
        ),
      );
    }

    Container noImage = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.tertiaryContainer,
        borderRadius: const BorderRadius.all(
          Radius.circular(Styles.borderRadius),
        ),
      ),
      child: Icon(
        Icons.landscape_rounded,
        color: Theme.of(context).colorScheme.tertiary,
        size: size / 2,
      ),
    );

    return imgPath != null ? showImage(imgPath!) : noImage;
  }
}
