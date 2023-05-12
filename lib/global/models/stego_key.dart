import 'dart:math';

class StegoKey {
  int offset = 0;
  int startChannel = 0;
  List<int> bits = [0];

  /// Creates Key object from key string
  StegoKey(String? stringKey, int imgWeight, int imgHeight) {
    if (stringKey == null || stringKey.isEmpty) {
      return;
    }

    List<int> asciiValues = [];
    for (int i = 0; i < stringKey.length; i++) {
      asciiValues.add(stringKey.codeUnitAt(i));
    }

    List<int> tmpBits = [];
    for (int i = 0; i < asciiValues.length; i++) {
      tmpBits.addAll(_decToBin(asciiValues.elementAt(i)));
    }

    int oneBits = tmpBits.reduce((x, y) => x + y);
    int asciiSum = asciiValues.reduce((x, y) => x + y);

    offset = (pow(asciiSum, 2).toInt() * oneBits) % (imgWeight * imgHeight);
    startChannel = stringKey.length % 3;
    bits = tmpBits;
  }

  List<int> _decToBin(int decimal) {
    String binString = decimal.toRadixString(2);
    return binString
        .padLeft(8, '0')
        .split('')
        .map((digit) => int.parse(digit))
        .toList();
  }
}
