class ProcessingResult {
  bool success = false;
  String? message;
  String? filePath;

  /// Used as result of hiding or revealing.
  ProcessingResult();

  /// Fail with error message
  void fail(String message) {
    success = false;
    message = message;
  }

  /// Use if whole operation was success
  void succeed(String message) {
    success = true;
    message = message;
  }
}
