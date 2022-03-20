import 'dart:io';
import 'package:csv/csv.dart';
import 'interfaces/list_interface.dart';

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

  /// Creates a row of data to append to a CSV file
  String _createRow(String item) {
    int timestamp = DateTime.now().millisecondsSinceEpoch;

    return ListToCsvConverter().convert([
          [item, timestamp]
        ]) +
        '\r\n';
  }

  @override
  void remove(int i) {
    if (i < 0) {
      throw Exception('Index cannot be below zero!');
    }

    List<List<dynamic>> rows = _getRows();

    if (i > rows.length) {
      throw Exception('Index $i out of range!');
    }

    if (rows.isEmpty) {
      throw Exception('No items to remove!');
    }

    i = i == 0 ? rows.length - 1 : i - 1;
    rows.removeAt(i);

    _rewriteRows(rows);
  }

  /// Returns a list of all data rows in the CSV file
  List<List<dynamic>> _getRows() {
    var rows = CsvToListConverter().convert(_todoList.readAsStringSync());
    rows.removeAt(0);

    return rows;
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
