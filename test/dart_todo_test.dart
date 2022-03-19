import 'dart:io';
import 'package:test/test.dart';
import '../src/todo_list.dart';

void main() {
  group('TodoList', () {
    test('TodoList creates a new file when initialised', () {
      String path = 'test.csv';
      expect(File(path).existsSync(), false);
      TodoList(path);
      expect(File(path).existsSync(), true);
      File(path).deleteSync(recursive: true);
    });
  });
}
