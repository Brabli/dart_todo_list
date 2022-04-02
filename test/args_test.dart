import 'package:test/test.dart';
import 'package:dart_todo/args.dart';
import 'package:dart_todo/enums/option.dart';

void main() {
  group('Args.option', () {
    test('Option is null if no option is passed', () {
      Args args = Args(_createArgs('test'));
      expect(args.option, null);
    });

    test('Throws exception if option is invalid', () {
      expect(() {
        Args(['-']);
      }, throwsException);
      expect(() {
        Args(['--']);
      }, throwsException);
      expect(() {
        Args(['--zzz']);
      }, throwsException);
    });

    test('Option is correct if a short flag is passed first', () {
      Args args = Args(_createArgs('-r test'));
      expect(args.option, Option.remove);
    });

    test('Option is correct if a long flag is passed first', () {
      Args args1 = Args(_createArgs('--remove test'));
      Args args2 = Args(_createArgs('--remove=1 test'));
      expect(args1.option, Option.remove);
      expect(args2.option, Option.remove);
    });
  });

  group('Args.optionArgs', () {
    test('Option args is null if no arguments are provided', () {
      Args args1 = Args(_createArgs('-r test'));
      Args args2 = Args(_createArgs('--remove test'));
      expect(args1.optionArgs, null);
      expect(args2.optionArgs, null);
    });

    test(
        'Option args throws an exception if no arguments are provided after an equals sign',
        () {
      expect(() {
        Args(['--remove=']);
      }, throwsException);
    });

    test('Option args are returned in a list', () {
      Args args1 = Args(_createArgs('--remove=1 test'));
      Args args2 = Args(_createArgs('--remove=1,2,3 test'));
      Args args3 = Args(_createArgs('-r1 test'));
      Args args4 = Args(_createArgs('-r1,2,3 test'));
      expect(args1.optionArgs, ['1']);
      expect(args2.optionArgs, ['1', '2', '3']);
      expect(args3.optionArgs, ['1']);
      expect(args4.optionArgs, ['1', '2', '3']);
    });

    test('Option args ignore additional equals signs', () {
      Args args = Args(_createArgs('--remove=1,=2,=3= test'));
      expect(args.optionArgs, ['1', '2', '3']);
    });

    test('Option args does not include empty arguments', () {
      Args args1 = Args(_createArgs('--remove=,,, test'));
      Args args2 = Args(_createArgs('--remove=1,,,2 test'));
      Args args3 = Args(_createArgs('-r,,, test'));
      Args args4 = Args(_createArgs('-r1,,,2 test'));
      expect(args1.optionArgs, null);
      expect(args2.optionArgs, ['1', '2']);
      expect(args3.optionArgs, null);
      expect(args4.optionArgs, ['1', '2']);
    });
  });

  group('Args.item', () {
    String item = 'This is a test item';

    test('returns null if no item is found', () {
      Args args1 = Args(_createArgs('-r1'));
      Args args2 = Args(_createArgs('--remove'));
      Args args3 = Args(_createArgs(''));
      expect(args1.item, null);
      expect(args2.item, null);
      expect(args3.item, null);
    });

    test('is returned when no options are passed', () {
      Args args = Args(_createArgs(item));
      expect(args.item, item);
    });

    test('is returned when options are passed', () {
      Args args1 = Args(_createArgs('-r $item'));
      Args args2 = Args(_createArgs('-r1,2,3 $item'));
      Args args3 = Args(_createArgs('--remove $item'));
      Args args4 = Args(_createArgs('--remove=1 $item'));
      expect(args1.item, item);
      expect(args2.item, item);
      expect(args3.item, item);
      expect(args4.item, item);
    });

    test('capitalises the first letter of an item', () {
      Args args = Args(_createArgs(item.toLowerCase()));
      expect(args.item, item);
    });
  });
}

/// Creates a list of arguments from a string
List<String> _createArgs(String argsString) {
  return argsString.split(' ');
}
