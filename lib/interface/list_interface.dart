abstract class ListInterface {
  /// Adds a new row to the CSV file
  void add(String item);

  /// Removes a list item at the given ONE BASED index
  void remove(int index);

  /// Returns a List of all the items in the list
  List<String> getItems();
}
