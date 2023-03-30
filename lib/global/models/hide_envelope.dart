import 'dart:io';
import 'dart:ui';

import 'package:steganosaurus/global/models/validation_result.dart';

class HideEnvelope {
  HideEnvelope({this.imgPath, this.filePath, this.encryptKey});

  String? imgPath;
  String? filePath;
  String? encryptKey;

  bool areFilesSelected() {
    return imgPath != null && filePath != null;
  }

  Future<ValidationResult> validate() async {
    if (imgPath == null) {
      return ValidationResult(false, 'err.selectImg');
    } else if (filePath == null) {
      return ValidationResult(false, 'err.selectFile');
    } else if (!File(imgPath!).existsSync()) {
      return ValidationResult(false, 'err.selectDiffImg');
    } else if (!File(filePath!).existsSync()) {
      return ValidationResult(false, 'err.selectDiffFile');
    }

    // Counting image message capacity and file size (For LSB algorithm)
    final ImmutableBuffer buffer =
        await ImmutableBuffer.fromUint8List(File(imgPath!).readAsBytesSync());
    final imgDesc = await ImageDescriptor.encoded(buffer);
    final double imgCapacity = (imgDesc.width * imgDesc.height * 3) / 8;

    imgDesc.dispose();
    buffer.dispose();

    final fileSize = File(filePath!).lengthSync();

    if (fileSize > imgCapacity) {
      return ValidationResult(false, 'err.fileTooLarge');
    } else {
      return ValidationResult(true, 'Everything is valid');
    }
  }
}
