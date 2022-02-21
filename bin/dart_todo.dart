import 'dart:io';
import 'package:dart_todo/todo_list.dart';

void main(List<String> arguments) {
  /// Creates a file
  // File('./test.csv').createSync();

  var todo = TodoList('./test.csv');
  print(todo.csv?[0][0]);
}
