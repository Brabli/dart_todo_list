extension StringExtension on String {
  /// Captializes the first letter of a string.
  String capitalize() {
    return isEmpty
        ? ''
        : "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
