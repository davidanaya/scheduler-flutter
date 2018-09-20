import 'dart:collection';

class Meal {
  final String name;
  final List<String> _food = [];

  Meal(this.name);

  UnmodifiableListView<String> get food => UnmodifiableListView(_food);

  void addFood(String food) {
    if (!_food.contains(food)) _food.add(food);
  }

  void removeFood(String food) {
    _food.remove(food);
  }

  bool isEmpty() {
    return name.isEmpty;
  }

  static Meal clone(Meal meal, String name) {
    var newMeal = Meal(name);
    meal.food.forEach(newMeal.addFood);
    return newMeal;
  }

  static int maxFoodIngredients = 4;

  @override
  String toString() {
    return '$name -> $food';
  }
}
