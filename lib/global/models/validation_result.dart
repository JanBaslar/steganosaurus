class ValidationResult {
  bool isValid;
  String message;

  /// Used as result of validating form field.
  ValidationResult._(this.isValid, this.message);

  static ValidationResult notValid(String message) {
    return ValidationResult._(false, message);
  }

  static ValidationResult valid() {
    return ValidationResult._(true, 'Everything is valid');
  }
}
