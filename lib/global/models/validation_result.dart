class ValidationResult {
  bool isValidated;
  String message;

  /// Used as result of validating form field.
  ValidationResult(this.isValidated, this.message);
}
