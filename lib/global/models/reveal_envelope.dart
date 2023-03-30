import 'dart:io';

import 'package:steganosaurus/global/models/validation_result.dart';

class RevealEnvelope {
  RevealEnvelope({this.imgPath, this.decryptKey});

  String? imgPath;
  String? decryptKey;

  bool isImgSelected() {
    return imgPath != null;
  }

  ValidationResult validate() {
    if (imgPath == null) {
      return ValidationResult(false, 'err.selectImg');
    } else if (!File(imgPath!).existsSync()) {
      return ValidationResult(false, 'err.selectDiffImg');
    } else {
      return ValidationResult(true, 'Everything is valid');
    }
  }
}
