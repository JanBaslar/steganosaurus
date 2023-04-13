import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class HidingController {
  Image? coverImage;

  /// Controller used for hiding files into images
  HidingController();

  Future<void> hello() async {
    File file =
        File("C:/School/BP/BakalarskaPrace/Assets/PlainSteganosaurus.svg");
    Uint8List bytes = file.readAsBytesSync();
    print(bytes.toString());
    File newFile =
        await File("C:/Users/jbaslar/Downloads/sresult.svg").create();
    newFile.writeAsBytesSync(bytes);
  }
}
