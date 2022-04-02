import '../enum/option.dart';

abstract class ArgsInterface {
  /// Returns the passed option
  Option? get option;

  /// Returns a list of any option specific arguments
  List<dynamic>? get optionArgs;

  /// Returns an item to add if one was passed.
  String? get item;
}
