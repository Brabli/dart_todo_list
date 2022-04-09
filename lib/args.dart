import 'enum/option.dart';
import 'interface/args_interface.dart';

class Args extends ArgsInterface {
  final Option? _option;
  final List? _optionArgs;
  final String? _item;

  Args(this._option, this._optionArgs, this._item);

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
}
