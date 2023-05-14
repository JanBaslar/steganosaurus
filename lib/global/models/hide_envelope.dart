import 'dart:io';
import 'dart:ui';

import 'package:permission_handler/permission_handler.dart';
import 'package:steganosaurus/global/models/validation_result.dart';

class HideEnvelope {
  HideEnvelope({this.imgPath, this.filePath, this.encryptKey});

  String? imgPath;
  String? filePath;
  String? encryptKey;
  String? resultPath;

  bool areFilesSelected() {
    return imgPath != null && filePath != null;
  }

  Future<ValidationResult> validate() async {
    if (imgPath == null) {
      return ValidationResult.notValid('err.selectImg');
    } else if (filePath == null) {
      return ValidationResult.notValid('err.selectFile');
    } else if (!File(imgPath!).existsSync()) {
      return ValidationResult.notValid('err.selectDiffImg');
    } else if (!File(filePath!).existsSync()) {
      return ValidationResult.notValid('err.selectDiffFile');
    }

    // Computing image message capacity and file size (For own LSB algorithm)
    final ImmutableBuffer buffer =
        await ImmutableBuffer.fromUint8List(File(imgPath!).readAsBytesSync());
    final imgDesc = await ImageDescriptor.encoded(buffer);
    final double imgCapacity = ((imgDesc.width * imgDesc.height * 3) - 160) / 8;

    imgDesc.dispose();
    buffer.dispose();

    final fileSize = File(filePath!).lengthSync();

    if (fileSize > imgCapacity) {
      return ValidationResult.notValid('err.fileTooLarge');
    } else {
      PermissionStatus status = await Permission.manageExternalStorage.status;
      if (status.isDenied) {
        status = await Permission.manageExternalStorage.request();
      }

      if (status.isDenied) {
        return ValidationResult.notValid('err.permDeny');
      }

      resultPath =
          '/storage/emulated/0/Steganosaurus/Hidden_${DateTime.now().millisecondsSinceEpoch}.png';
      return ValidationResult.valid();
    }
  }
}
