import 'args.dart';
import 'enum/option.dart';
import 'extension/extensions.dart';

class Parser {
  /// Parses a list of command line arguments and returns an Args object.
  static Args parse(List<String> args) {
    return Args(_getOption(args), _getOptionArgs(args), _getItem(args));
  }

  /// Returns the option provided as the first argument or null
  static Option? _getOption(List<String> args) {
    var firstArg = args.first;
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
  static Option? _getCorrectOption(String option) {
    switch (option) {
      case 'remove':
      case 'r':
        return Option.remove;
      default:
        throw Exception('Invalid argument provided!');
    }
  }

  /// Returns a List of option arguments or null
  static List<String>? _getOptionArgs(List<String> args) {
    var firstArg = args.first;
    if (_getOption(args) == null) {
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
  static String? _getItem(List<String> args) {
    if (_getOption(args) == null) {
      String item = args.join(' ').trim().capitalize();

      return item.isEmpty ? null : item;
    }

    args.removeFirst();
    if (args.isEmpty) return null;
    String item = args.join(' ').trim().capitalize();

    return item;
  }
}
