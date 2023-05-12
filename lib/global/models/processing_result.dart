class ProcessingResult {
  bool success;
  String? message;
  String? filePath;

  /// Used as result of hiding or revealing.
  ProcessingResult._(this.success, this.message, this.filePath);

  /// Fail with error message
  static ProcessingResult fail(String message) {
    return ProcessingResult._(false, message, null);
  }

  /// Use if whole operation was success
  static ProcessingResult succeed(String filePath) {
    return ProcessingResult._(true, null, filePath);
  }
}
