extension ListExtension on List {
  /// Removes and returns the first object in this list.
  ///
  /// The list must be growable and non-empty.
  /// ```dart
  /// final parts = <String>['head', 'shoulder', 'knees', 'toes'];
  /// final retVal = parts.removeLast(); // head
  /// print(parts); // [shoulder, knees, toes]
  /// ```
  dynamic removeFirst() {
    return removeAt(0);
  }
}
