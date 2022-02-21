import 'dart:io';
import 'package:csv/csv.dart';
import 'package:dart_todo/todo_list_abstract_class.dart';

// class TodoList extends TodoListInterface {}
class TodoList {
  List<List<dynamic>>? csv;

  TodoList(String path) {
    File csvFile = File(path)..createSync();
    String csvContent = csvFile.readAsStringSync();
    csv = CsvToListConverter().convert(csvContent);
  }
}
