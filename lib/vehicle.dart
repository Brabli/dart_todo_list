class Vehicle {
  String make = 'none';
  String model = 'none';
  int manufactureYear = 9999;
  int vehicleAge = 9999;
  String color = 'none';

  Vehicle({
    required this.make,
    required this.model,
    required this.manufactureYear,
    required this.color,
  });

  Map<String, dynamic> get map {
    return {
      "make": make,
      "model": model,
      "manufactureYear": manufactureYear,
      "color": color,
    };
  }

  int get age {
    return DateTime.now().year - manufactureYear;
  }

  set age(int currentYear) {
    vehicleAge = currentYear - manufactureYear;
  }
}

void main() {
  Vehicle car = Vehicle(
      make: "Honda", model: "Civic", manufactureYear: 2010, color: "red");
  print(car.map);
}
