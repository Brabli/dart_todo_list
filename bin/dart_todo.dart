import 'dart:io' show Directory, File, Platform;
// import 'package:dart_todo/todo_list.dart';

void main(List<String> arguments) {
  String currentPath = Directory.current.path;
  String homePath = Platform.environment['HOME']!;
  List pathVar = Platform.environment['PATH']!.split(':');

  /// Creates a file at /Users/bradley
  File('$homePath/test.csv').createSync();

  print(currentPath);
  print(pathVar);
}

  // var todo = TodoList('./test.csv');
  // print(todo.csv?[0][0]);}
