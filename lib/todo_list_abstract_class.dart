abstract class TodoListInterface {
  /// Adds a new list item
  void add(String item);

  /// Removes a list item at the given ONE BASED index
  void remove(int index);

  /*
  Item CSV Fields
  Item, Index, Time and Date Added, Tasks
  */
}
