import 'dart:io';
import 'package:csv/csv.dart';
import 'interfaces/list_interface.dart';

// class TodoList extends TodoListInterface {}
class TodoList extends ListInterface {
  List<List<dynamic>>? csv;

  TodoList(String path) {
    File csvFile = File(path)..createSync();
    String csvContent = csvFile.readAsStringSync();
    csv = CsvToListConverter().convert(csvContent);
  }

  void add(String a) {
    print('Added');
  }

  void remove(int i) {
    print('Removed');
  }
}
