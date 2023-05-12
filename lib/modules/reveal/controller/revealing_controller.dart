import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:image/image.dart';
import 'package:steganosaurus/global/models/reveal_envelope.dart';

import '../../../global/models/processing_result.dart';
import '../../../global/models/stego_key.dart';

class RevealingController {
  /// Controller used for revealing files from images
  RevealingController();

  /// Start revealing file into image
  Future<ProcessingResult> revealFromImage(RevealEnvelope envelope) async {
    return await compute(_processRevealing, envelope);
  }

  /// Main revealing method
  Future<ProcessingResult> _processRevealing(RevealEnvelope envelope) async {
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

    StegoKey key;
    try {
      key = StegoKey(envelope.decryptKey, w, h);
    } catch (e) {
      return ProcessingResult.fail('err.keyFail');
    }

    List<int> bytesHolder = [];
    String extension = '';
    try {
      // Main algorithm
      int pos = key.offset;
      int pixels = w * h;
      int shift = (pixels / 13).floor();
      int channel = key.startChannel;
      int keyIndex = 0;
      int loop = 0;
      int cycle = 1;
      int readInCycle = 0;
      int stop = pixels - (pixels % 13);

      int endByte = 20;
      int readBytes = 0;
      while (readBytes < endByte) {
        List<int> bits = [];
        for (int j = 0; j < 8; j++) {
          if (readInCycle % 13 == 0 && readInCycle != 0) {
            loop++;
            pos = key.offset + loop;
          }

          int bit = _getBit((pos % w), (pos / w).floor(), channel, image);
          bits.add((bit + key.bits[keyIndex]) % 2);
          readInCycle++;
          channel = (channel++) % 3;
          pos = (pos + shift) % pixels;
          keyIndex = keyIndex++ % key.bits.length;

          if (readInCycle == stop) {
            readInCycle = 0;
            pos = key.offset;
            channel = (key.startChannel + cycle) % 3;
            loop = 0;
            cycle++;
            if (cycle == 4) {
              return ProcessingResult.fail('err.bigFail');
            }
          }
        }
        bytesHolder.add(_bitsToByte(bits));
        readBytes++;
        if (readBytes == 5) {
          extension = String.fromCharCodes(bytesHolder).trim();
          if (extension.isNotEmpty) {
            extension = '.$extension';
          }
          bytesHolder.clear();
        } else if (readBytes == 15) {
          try {
            int fileSize = int.parse(String.fromCharCodes(bytesHolder).trim());
            endByte = fileSize + 15;
            bytesHolder.clear();
          } catch (e) {
            return ProcessingResult.fail('err.revealFail');
          }
        }
      }
    } catch (e) {
      return ProcessingResult.fail('err.revealFail');
    }

    // Writing file to tmp folder.
    try {
      Uint8List fileBytes = Uint8List.fromList(bytesHolder);
      File(envelope.resultPathNoExt! + extension).writeAsBytesSync(fileBytes);
    } catch (e) {
      return ProcessingResult.fail('err.fileSaveFail');
    }

    return ProcessingResult.succeed(envelope.resultPathNoExt! + extension);
  }

  /// Gets bit value from channel from position x and y in image
  int _getBit(int x, int y, int channel, Image image) {
    Pixel pixel = image.getPixelSafe(x, y);
    return (pixel[channel] % 2).toInt();
  }

  /// Converts list of bits to decimal byte
  int _bitsToByte(List<int> bits) {
    int result = 0;
    for (int i = 0; i < 8; i++) {
      result += bits[7 - i] << i;
    }
    return result;
  }
}
