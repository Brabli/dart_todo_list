import 'dart:io';
import 'package:csv/csv.dart';
import 'package:test/test.dart';
import '../src/todo_list.dart';

void main() {
  group('TodoList', () {
    String path = 'test.csv';

    tearDown(() {
      File(path).deleteSync(recursive: true);
    });

    test('TodoList creates a new file when initialised', () {
      TodoList(path);
      expect(File(path).existsSync(), true);
    });

    test('TodoList adds a new row to the list', () {
      TodoList todoList = TodoList(path);
      todoList.add('An example item');
      expect(_countRows(todoList), 1);
      todoList.add('An example item');
      todoList.add('An example item');
      expect(_countRows(todoList), 3);
    });

    group('remove()', () {
      test('Removes an item at the given index', () {
        TodoList todoList = TodoList(path);
        todoList.add('Item 1');
        todoList.add('Item 2');
        todoList.remove(1);
        expect(_countRows(todoList), 1);
        expect(_getRows(todoList).first[0], 'Item 2');
      });

      test('Removes the last item if 0 is passed as the index', () {
        TodoList todoList = TodoList(path);
        todoList.add('Item 1');
        todoList.add('Item 2');
        todoList.remove(0);
        expect(_countRows(todoList), 1);
        expect(_getRows(todoList).first[0], 'Item 1');
      });

      test('Throws an exception if index is below zero', () {
        TodoList todoList = TodoList(path);
        expect(() => todoList.remove(-1), throwsException);
      });

      test('Throws an error if index is out of range', () {
        TodoList todoList = TodoList(path);
        expect(() => todoList.remove(1), throwsException);
        expect(() => todoList.remove(0), throwsException);
      });
    });
  });
}

/// Returns the number of rows (excluding keys) in a CSV file
int _countRows(TodoList todoList) {
  int rows = CsvToListConverter().convert(todoList.toString()).length - 1;
  if (rows < 0) {
    throw Exception('List keys have been removed!');
  }

  return rows;
}

/// Returns a list of all the data rows in a CSV file
List<List<dynamic>> _getRows(TodoList todoList) {
  var rows = CsvToListConverter().convert(todoList.toString());
  rows.removeAt(0);

  return rows;
}
