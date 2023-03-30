import 'package:flutter/services.dart';

class HidingController {
  HidingController();

  static const platform = MethodChannel('com.steganosaurus.epic/epic');

  String hello() {
    return 'hello';
  }
}
