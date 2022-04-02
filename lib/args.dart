import 'enum/option.dart';
import 'interface/args_interface.dart';

class Args extends ArgsInterface {
  Option? _option;
  List? _optionArgs;
  String? _item;

  Args(List<String> args) {
    if (args.isNotEmpty) {
      _option = _getOption(args[0]);
      _optionArgs = _getOptionArgs(args[0]);
      _item = _getItem(args);
    }
  }

  @override
  Option? get option {
    return _option;
  }

  @override
  List<dynamic>? get optionArgs {
    return _optionArgs;
  }

  @override
  String? get item {
    return _item;
  }

  /// Returns the option provided as the first argument or null
  Option? _getOption(String firstArg) {
    if (firstArg == '-' || firstArg == '--') {
      throw Exception('Expected an argument but none were found!');
    }

    if (firstArg.startsWith('--')) {
      String option = firstArg.substring(2).split('=')[0];
      return _getCorrectOption(option);
    }

    if (firstArg.startsWith('-')) {
      String option = firstArg.substring(1, 2);
      return _getCorrectOption(option);
    }

    return null;
  }

  /// Returns the appropriate option enum from a string
  Option? _getCorrectOption(String option) {
    switch (option) {
      case 'remove':
      case 'r':
        return Option.remove;
      default:
        throw Exception('Invalid argument provided!');
    }
  }

  // @TODO continue refactoring
  /// Returns a List of option arguments or null
  List<String>? _getOptionArgs(String firstArg) {
    if (_option == null) {
      return null;
    }

    if (firstArg.startsWith('--')) {
      var splitBits = firstArg.split('=');
      if (splitBits.length >= 2) {
        splitBits.removeFirst();
        String optionArgs = splitBits.reduce((val, ele) => val += ele);

        if (optionArgs.isEmpty) {
          throw Exception('No option arguments provided!');
        }

        List<String> args =
            optionArgs.split(',').where((e) => e.isNotEmpty).toList();
        if (args.isNotEmpty) {
          return args;
        }
      }

      return null;
    }

    if (firstArg.startsWith('-')) {
      String stringArgs = firstArg.substring(2);
      if (stringArgs.isNotEmpty) {
        List<String> args =
            stringArgs.split(',').where((e) => e.isNotEmpty).toList();
        if (args.isNotEmpty) return args;
      }
    }

    return null;
  }

  /// Returns the item or null if not provided
  String? _getItem(List<String> args) {
    if (_option == null) {
      String item = args.join(' ').trim().capitalize();

      return item.isEmpty ? null : item;
    }

    args.removeFirst();
    if (args.isEmpty) return null;
    String item = args.join(' ').trim().capitalize();

    return item;
  }
}

// @TODO Put this somewhere that makes sense and compare it to removeLast()
extension RemoveFirst on List {
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

extension StringExtension on String {
  /// Captializes the first letter of a string.
  String capitalize() {
    return isEmpty
        ? ''
        : "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
