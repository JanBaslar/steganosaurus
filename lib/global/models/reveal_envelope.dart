import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:steganosaurus/global/models/validation_result.dart';

class RevealEnvelope {
  RevealEnvelope({this.imgPath, this.decryptKey});

  String? imgPath;
  String? decryptKey;
  String? resultPathNoExt;

  bool isImgSelected() {
    return imgPath != null;
  }

  Future<ValidationResult> validate() async {
    if (imgPath == null) {
      return ValidationResult.notValid('err.selectImg');
    } else if (!File(imgPath!).existsSync()) {
      return ValidationResult.notValid('err.selectDiffImg');
    } else {
      resultPathNoExt =
          '${(await getTemporaryDirectory()).path}\\Steganosaurus\\Revealed_${DateTime.now().millisecondsSinceEpoch}';
      return ValidationResult.valid();
    }
  }
}
