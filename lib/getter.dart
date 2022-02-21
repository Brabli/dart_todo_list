class TestGetSet {
  int num;
  late String _name;

  TestGetSet(this.num, String name) {
    this._name = 'Sir $name';
  }

  void printName() => print(name);
  void printRealName() => print(name);

  set name(String name) {
    _name = _name.toUpperCase();
  }

  String get name {
    return _name.toUpperCase();
  }
}

void main() {
  var x = TestGetSet(10, 'Rodney');
  x.printName();
  x.printRealName();
  print(x.printName.runtimeType);
}
