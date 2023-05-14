import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:image/image.dart';
import 'package:steganosaurus/global/models/hide_envelope.dart';
import 'package:steganosaurus/global/models/processing_result.dart';
import 'package:steganosaurus/global/models/stego_key.dart';

class HidingController {
  /// Controller used for hiding files into images
  HidingController();

  /// Start hiding file into image
  Future<ProcessingResult> hideIntoImage(HideEnvelope envelope) async {
    return await compute(_processHiding, envelope);
  }

  /// Main hiding method
  Future<ProcessingResult> _processHiding(HideEnvelope envelope) async {
    Image image;
    int w, h;
    try {
      image = (await decodeImageFile(envelope.imgPath!))!;
      w = image.width;
      h = image.height;
    } catch (e) {
      return ProcessingResult.fail('err.imgLoadFail');
    }

    if (image.numChannels < 3) {
      return ProcessingResult.fail('err.only3chan');
    }

    Uint8List fileBytes;
    try {
      fileBytes = File(envelope.filePath!).readAsBytesSync();
    } catch (e) {
      return ProcessingResult.fail('err.fileLoadFail');
    }

    StegoKey key;
    try {
      key = StegoKey(envelope.encryptKey, w, h);
    } catch (e) {
      return ProcessingResult.fail('err.keyFail');
    }

    final int fileSize = fileBytes.length;
    final double imgCapacity = ((w * h * 3) - 160) / 8;
    if (fileSize > imgCapacity) {
      return ProcessingResult.fail('err.fileTooLarge');
    }

    try {
      String? extension = _get5Extension(envelope.filePath!);
      if (extension == null) {
        return ProcessingResult.fail('err.extTooLong');
      }

      Uint8List uint8Ext = _stringToUint8List(extension);
      String fileSizeStr = fileSize.toString().padLeft(10, ' ');
      Uint8List uint8Size = _stringToUint8List(fileSizeStr);
      BytesBuilder builder = BytesBuilder();
      builder.add(uint8Ext);
      builder.add(uint8Size);
      builder.add(fileBytes);
      Uint8List secretBytes = builder.toBytes();

      // Main algorithm
      int pos = key.offset;
      int pixels = w * h;
      int shift = (pixels / 13).floor();
      int channel = key.startChannel;
      int keyIndex = 0;
      int loop = 0;
      int cycle = 1;
      int writtenInCycle = 0;
      int stop = pixels - (pixels % 13);
      for (int i = 0; i < secretBytes.length; i++) {
        List<int> bits = _byteToBits(secretBytes.elementAt(i));
        for (int j = 0; j < 8; j++) {
          if (writtenInCycle % 13 == 0 && writtenInCycle != 0) {
            loop++;
            pos = key.offset + loop;
          }

          int secretBit = (bits[j] + key.bits[keyIndex]) % 2;
          _hideBit((pos % w), (pos / w).floor(), channel, secretBit, image);
          writtenInCycle++;
          channel = (channel++) % 3;
          pos = (pos + shift) % pixels;
          keyIndex = keyIndex++ % key.bits.length;

          if (writtenInCycle == stop) {
            writtenInCycle = 0;
            pos = key.offset;
            channel = (key.startChannel + cycle) % 3;
            loop = 0;
            cycle++;
            if (cycle == 4) {
              return ProcessingResult.fail('err.bigFail');
            }
          }
        }
      }
    } catch (e) {
      return ProcessingResult.fail('err.bigFail');
    }

    // Writing image to tmp folder.
    try {
      await encodePngFile(envelope.resultPath!, image);
    } catch (e) {
      return ProcessingResult.fail(e.toString());
    }

    return ProcessingResult.succeed(envelope.resultPath!);
  }

  /// Hides bit in channel in x and y position in image
  void _hideBit(int x, int y, int channel, int value, Image image) {
    Pixel pixel = image.getPixelSafe(x, y);
    int pixValue = pixel[channel].toInt();
    int pixBit = pixValue % 2;

    if (value == pixBit) {
      return;
    }

    if (pixBit == 1) {
      pixValue--;
    } else {
      pixValue++;
    }

    switch (channel) {
      case 0:
        pixel.setRgb(pixValue, pixel[1], pixel[2]);
        break;
      case 1:
        pixel.setRgb(pixel[0], pixValue, pixel[2]);
        break;
      case 2:
        pixel.setRgb(pixel[0], pixel[1], pixValue);
        break;
    }
  }

  /// Returns file extension of length 5.
  String? _get5Extension(String fileName) {
    if (fileName.contains('.')) {
      String ext = fileName.split('.').last;
      if (ext.length > 5) {
        return null;
      } else {
        return ext.padLeft(5, ' ');
      }
    } else {
      return '     ';
    }
  }

  /// Returns Uint8List from string.
  Uint8List _stringToUint8List(String str) {
    List<int> result = [];
    for (int i = 0; i < str.length; i++) {
      result.add(str.codeUnitAt(i));
    }
    return Uint8List.fromList(result);
  }

  /// Converts ASCII byte to bits
  List<int> _byteToBits(int byteASCII) {
    String binString = byteASCII.toRadixString(2);
    return binString
        .padLeft(8, '0')
        .split('')
        .map((digit) => int.parse(digit))
        .toList();
  }
}
