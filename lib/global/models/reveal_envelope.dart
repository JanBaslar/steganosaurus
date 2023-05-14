import 'dart:io';

import 'package:permission_handler/permission_handler.dart';
import 'package:steganosaurus/global/config.dart';
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
      PermissionStatus status = await Permission.storage.status;
      if (status.isDenied) {
        status = await Permission.storage.request();
      }

      if (status.isDenied) {
        return ValidationResult.notValid('err.permDeny');
      }

      resultPathNoExt =
          '${appFolder}Revealed_${DateTime.now().millisecondsSinceEpoch}';
      return ValidationResult.valid();
    }
  }
}
