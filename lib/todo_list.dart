import 'dart:io';
import 'package:csv/csv.dart';
import 'interface/list_interface.dart';

class TodoList extends ListInterface {
  static final String _fields = 'item,timestamp\r\n';
  late File _todoList;

  TodoList(String path) {
    if (File(path).existsSync()) {
      _todoList = File(path);
    } else {
      _todoList = File(path)..createSync();
      _todoList.writeAsStringSync(TodoList._fields);
    }
  }

  @override
  void add(String item) {
    String row = _createRow(item);
    _todoList.writeAsStringSync(row, mode: FileMode.append);
  }

  @override
  void remove(int index) {
    if (index < 0) {
      throw Exception('Index cannot be below zero!');
    }

    var rows = _getRows();

    if (index > rows.length) {
      throw Exception('Index $index out of range!');
    }

    if (rows.isEmpty) {
      throw Exception('No items to remove!');
    }

    index = index == 0 ? rows.length - 1 : index - 1;
    rows.removeAt(index);

    _rewriteRows(rows);
  }

  @override
  List<String> getItems() {
    var rows = _getRows();
    // This assumes that the item is first in the list
    return rows.map((row) => row.first.toString()).toList();
  }

  /// Returns a List of Lists containing the CSV row values
  List<List<dynamic>> _getRows() {
    var rows = CsvToListConverter().convert(_todoList.readAsStringSync());
    rows.removeAt(0);

    return rows;
  }

  /// Creates a row of CSV data to append to a CSV file
  String _createRow(String item) {
    int timestamp = DateTime.now().millisecondsSinceEpoch;

    return ListToCsvConverter().convert([
          [item, timestamp]
        ]) +
        '\r\n';
  }

  /// Rewrites all of the rows in the CSV file
  void _rewriteRows(List<List<dynamic>> rows) {
    _todoList.writeAsStringSync(TodoList._fields);
    String rowsAsString = ListToCsvConverter().convert(rows);
    _todoList.writeAsStringSync(rowsAsString, mode: FileMode.append);
  }

  @override
  String toString() {
    return _todoList.readAsStringSync();
  }
}
